"use strict";

const cds = require("@sap/cds");
const logger = cds.log("logger");
const utils = require("../../utils/Utils");

function _getAmountPropertiesForDataCleaning() {
    return [];
}

function insertData(aData, realm) {
    return new Promise(async (resolve, reject) => {
        const srv = cds.transaction(aData);
        if (!aData || aData.length === 0) {
            resolve(0);
            return;
        }

        logger.info(`Processing ${aData.length} SRProject records`);
        let aCleaningProperties = _getAmountPropertiesForDataCleaning();
        let i = 0;

        for (const oData of aData) {
            let oDataCleansed = utils.cleanData(aCleaningProperties, oData, realm);
            oDataCleansed = utils.processCustomFields(oDataCleansed);

            try {
                let res = await srv.run(
                    SELECT.from("sap.ariba.SRProject").where({
                        Realm: oDataCleansed.Realm,
                        ProjectId: oDataCleansed.ProjectId
                    })
                );

                if (res.length === 0) {
                    await srv.run(INSERT.into("sap.ariba.SRProject").entries(oDataCleansed));
                } else {
                    await srv.run(
                        UPDATE("sap.ariba.SRProject")
                            .set(oDataCleansed)
                            .where({
                                Realm: oDataCleansed.Realm,
                                ProjectId: oDataCleansed.ProjectId
                            })
                    );
                }
            } catch (e) {
                logger.error(`Error inserting SRProject: ${e}`);
                await srv.rollback();
                reject(e);
                break;
            }

            i++;
            if (i % 500 === 0) {
                logger.info(`Upserted ${i} SRProject records`);
            }
        }

        await srv.commit();
        resolve(aData.length);
    });
}

module.exports = { 
    insertData 
};
