"use strict";

const cds = require("@sap/cds");
const logger = cds.log('logger');
const utils = require("../../../utils/Utils");



//Amount fields in object
function _getAmountPropertiesForDataCleaning () {
    return ["Duration",
    "Amount",
    "ProposedAmount",
    "OrigProposedAmount",
    "OrigAmount",
    ];
}

function insertData(aData, realm)  {
    return new Promise(async function(resolve, reject)    {
   
        const srv = cds.transaction(aData);
        if (!aData || aData.length === 0) {
            resolve(0);
            return;
        }
        logger.info(`Processing ${aData.length} records`);
        var aCleaningProperties = _getAmountPropertiesForDataCleaning();
        let i=0;
        for(const oData of aData) {
            
            var oDataCleansed = utils.cleanData(aCleaningProperties, oData, realm);
            var oDataCleansed = utils.processCustomFields(oDataCleansed);
            try {
                //Select record by Unique key
                let res =  await srv.run ( SELECT.from ("sap.ariba.SalesContractWorkspace_AN").where(
                    { 
                        Realm : oDataCleansed.Realm ,
                        ProjectId : oDataCleansed.ProjectId }  )
                 );

                 if(res.length==0){
                     //New record, insert
                    await srv.run( INSERT .into ("sap.ariba.SalesContractWorkspace_AN") .entries (oDataCleansed) );
                                  
                 }else{
                     //Update existing record
                     //Full Load of SalesContractWorkspace_Organization SalesContractWorkspace_AllOwners SalesContractWorkspace_Suppliers SalesContractWorkspace_Commodity SalesContractWorkspace_Region
                     
                     let organizations = oDataCleansed["Organization"];
                     delete oDataCleansed["Organization"];
                    
                     let commodities = oDataCleansed["Commodity"];
                     delete oDataCleansed["Commodity"];

                     let owners = oDataCleansed["AllOwners"];
                     delete oDataCleansed["AllOwners"];

                     let affectedParties = oDataCleansed["AffectedParties"];
                     delete oDataCleansed["AffectedParties"];

                     let regions = oDataCleansed["Region"];
                     delete oDataCleansed["Region"];           
                    
                     await srv.run ( UPDATE ("sap.ariba.SalesContractWorkspace_AN") .set (oDataCleansed) .where(
                        { 
                            Realm : oDataCleansed.Realm ,
                            ProjectId : oDataCleansed.ProjectId } )
                     );

                     await _FullLoadOrganization(organizations,oDataCleansed.Realm,oDataCleansed.ProjectId,srv);
                     await _FullLoadOwners(owners,oDataCleansed.Realm,oDataCleansed.ProjectId,srv);
                     await _FullLoadCommodities(commodities,oDataCleansed.Realm,oDataCleansed.ProjectId,srv);
                     await _FullLoadAffectedParties(affectedParties,oDataCleansed.Realm,oDataCleansed.ProjectId,srv);
                     await _FullLoadRegions(regions,oDataCleansed.Realm,oDataCleansed.ProjectId,srv);
                     
                  
                 }
           
            } catch (e) {                
                logger.error(`Error on inserting data in database, aborting file processing, details ${e} `);
                await srv.rollback();
                //abort full file
                reject(e);
                break;
            }
            //Monitoring
            i++;
            if(i%500 ==0){
                logger.info(`Upsert ${i} records`);
            }

        }
        await srv.commit();
        resolve(aData.length);
    });

}

async function _FullLoadRegions(regions,Realm,ProjectId,srv){
    return new Promise(async (resolve,reject) =>{
       // const srv = cds.transaction(regions); 
        //Delete old records
        try {
            await srv.run(DELETE("sap.ariba.SalesContractWorkspace_Region").where({
                SalesContractWorkspace_Realm : Realm ,
                SalesContractWorkspace_ProjectId : ProjectId 
            }));
        }
        catch(e){
            logger.error(`Error on deleting from database, aborting file processing, details ${e} `);
            reject(e);
        }

        //Insert new records
        for (const re of regions){
            try {             
                
                re["SalesContractWorkspace_Realm"] = Realm;
                re["SalesContractWorkspace_ProjectId"] = ProjectId;
                await srv.run( INSERT .into ("sap.ariba.SalesContractWorkspace_Region") .entries (re) );
           
            } catch (e) {                
                logger.error(`Error on inserting data in database, aborting file processing, details ${e} `);
                reject(e);
                break;
            }
        }
        resolve();
    });
}

async function _FullLoadAffectedParties(affectedParties,Realm,ProjectId,srv){
    return new Promise(async (resolve,reject) =>{
       // const srv = cds.transaction(suppliers); 
        //Delete old records
        try {
            await srv.run(DELETE("sap.ariba.SalesContractWorkspace_AffectedParties").where({
                SalesContractWorkspace_Realm : Realm ,
                SalesContractWorkspace_ProjectId : ProjectId 
            }));
        }
        catch(e){
            logger.error(`Error on deleting from database, aborting file processing, details ${e} `);
            reject(e);
        }

        //Insert new records
        for (const ap of affectedParties){
            try {             
                
                ap["SalesContractWorkspace_Realm"] = Realm;
                ap["SalesContractWorkspace_ProjectId"] = ProjectId;
                await srv.run( INSERT .into ("sap.ariba.SalesContractWorkspace_AffectedParties") .entries (ap) );
           
            } catch (e) {                
                logger.error(`Error on inserting data in database, aborting file processing, details ${e} `);
                reject(e);
                break;
            }
        }
        resolve();
    });
}

async function _FullLoadCommodities(commodities,Realm,ProjectId,srv){
    return new Promise(async (resolve,reject) =>{
       // const srv = cds.transaction(commodities); 
        //Delete old records
        try {
            await srv.run(DELETE("sap.ariba.SalesContractWorkspace_Commodity").where({
                SalesContractWorkspace_Realm : Realm ,
                SalesContractWorkspace_ProjectId : ProjectId 
            }));
        }
        catch(e){
            logger.error(`Error on deleting from database, aborting file processing, details ${e} `);
            reject(e);
        }

        //Insert new records
        for (const comm of commodities){
            try {             
                
                comm["SalesContractWorkspace_Realm"] = Realm;
                comm["SalesContractWorkspace_ProjectId"] = ProjectId;
                await srv.run( INSERT .into ("sap.ariba.SalesContractWorkspace_Commodity") .entries (comm) );
           
            } catch (e) {                
                logger.error(`Error on inserting data in database, aborting file processing, details ${e} `);
                reject(e);
                break;
            }
        }
        resolve();
    });
}

async function _FullLoadOwners(owners,Realm,ProjectId,srv){
    return new Promise(async (resolve,reject) =>{
        //const srv = cds.transaction(owners); 
        //Delete old records
        try {
            await srv.run(DELETE("sap.ariba.SalesContractWorkspace_AllOwners").where({
                SalesContractWorkspace_Realm : Realm ,
                SalesContractWorkspace_ProjectId : ProjectId 
            }));
        }
        catch(e){
            logger.error(`Error on deleting from database, aborting file processing, details ${e} `);
            reject(e);
        }

        //Insert new records
        for (const owner of owners){
            try {             
                
                owner["SalesContractWorkspace_Realm"] = Realm;
                owner["SalesContractWorkspace_ProjectId"] = ProjectId;
                await srv.run( INSERT .into ("sap.ariba.SalesContractWorkspace_AllOwners") .entries (owner) );
           
            } catch (e) {                
                logger.error(`Error on inserting data in database, aborting file processing, details ${e} `);
                reject(e);
                break;
            }
        }
        resolve();
    });
}
 
async function _FullLoadOrganization(organizations,Realm,ProjectId,srv){
    return new Promise(async (resolve,reject) =>{
        //const srv = cds.transaction(organizations); 
        //Delete old records
        try {
            await srv.run(DELETE("sap.ariba.SalesContractWorkspace_Organization").where({
                SalesContractWorkspace_Realm : Realm ,
                SalesContractWorkspace_ProjectId : ProjectId 
            }));
        }
        catch(e){
            logger.error(`Error on deleting from database, aborting file processing, details ${e} `);
            reject(e);
        }

        //Insert new records
        for (const org of organizations){
            try {             
                
                org["SalesContractWorkspace_Realm"] = Realm;
                org["SalesContractWorkspace_ProjectId"] = ProjectId;
                await srv.run( INSERT .into ("sap.ariba.SalesContractWorkspace_Organization") .entries (org) );
           
            } catch (e) {                
                logger.error(`Error on inserting data in database, aborting file processing, details ${e} `);
                reject(e);
                break;
            }
        }
        resolve();
    });
}


module.exports = {
    insertData
}