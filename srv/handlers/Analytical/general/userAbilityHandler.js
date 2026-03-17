"use strict";

const cds = require("@sap/cds");
const logger = cds.log("logger");
const utils = require("../../../utils/Utils");

function _getAmountPropertiesForDataCleaning() {
    return [];
}

function _FlatteningData (oData) {

    //Structure flattening
    oData.UserDataUserId = oData.UserData.UserId;
    oData.UserDataSourceSystem = oData.UserData.SourceSystem;
    oData.SourceSystemId = oData.SourceSystem.SourceSystemId;

    return oData;
}

function insertData(aData, realm) {
    return new Promise(async (resolve, reject) => {
        const srv = cds.transaction(aData);
        if (!aData || aData.length === 0) {
            resolve(0);
            return;
        }

        logger.info(`Processing ${aData.length} UserAbility records`);
        let aCleaningProperties = _getAmountPropertiesForDataCleaning();
        let i = 0;

        for (const oData of aData) {
            let oDataCleansed = utils.cleanData(aCleaningProperties, oData, realm);
            oDataCleansed = _FlatteningData(oData);
            oDataCleansed = utils.processCustomFields(oDataCleansed);

            try {
                let res = await srv.run(
                    SELECT.from("sap.ariba.UserAbilityFact_AN").where({
                        Realm: oDataCleansed.Realm,
                        UserDataUserId: oDataCleansed.UserDataUserId,
                        UserDataSourceSystem: oDataCleansed.UserDataSourceSystem,
                        SourceSystemId: oDataCleansed.SourceSystemId
                    })
                );

                if (res.length === 0) {
                    await srv.run(INSERT.into("sap.ariba.UserAbilityFact_AN").entries(oDataCleansed));
                } else {
                    await srv.run(
                        UPDATE("sap.ariba.UserAbilityFact_AN")
                            .set(oDataCleansed)
                            .where({
                                Realm: oDataCleansed.Realm,
                                UserDataUserId: oDataCleansed.UserDataUserId,
                                UserDataSourceSystem: oDataCleansed.UserDataSourceSystem,
                                SourceSystemId: oDataCleansed.SourceSystemId
                            })
                    );
                }
            } catch (e) {
                logger.error(`Error inserting UserAbilityFact_AN: ${e}`);
                await srv.rollback();
                reject(e);
                break;
            }

            i++;
            if (i % 500 === 0) {
                logger.info(`Upserted ${i} UserAbilityFact_AN records`);
            }
        }

        await srv.commit();
        resolve(aData.length);
    });
}

module.exports = {
    insertData
};
