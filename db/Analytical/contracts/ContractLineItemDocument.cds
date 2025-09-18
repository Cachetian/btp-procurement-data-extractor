namespace sap.ariba;
using { managed } from '@sap/cds/common';

using sap.ariba.type as types from '../types';

/**
    Name:	                Contract Line Item Document
    Class Name:	            ariba.analytics.fact.ContractLineItemDocument
    Description:	        Contract Line Items Document
    Database Table Name:	FACT_CONTRACT_LINE_ITEM_DOCUMENT

*/
entity ContractLineItemDocument_AN : managed,types.customFields  {
    key Realm                                           : String(50);
    Key DocumentId                                      : String(150);
        LoadCreateTime                                  : DateTime;
        LoadUpdateTime                                  : DateTime;
        EffectiveDate                                   : types.day;
        Title                                           : String(765);
        VersionNumber                                   : Integer;
        AllowFormulas                                   : Boolean;
        AllowAdvancedPricingConditions                  : Boolean;
        PricingConditionValidityPeriodType              : Integer;
        ValidityPeriodDuration                          : Integer;
        AllowPeriodQuantityForEvent                     : Boolean;
        AllowSupplierToViewPeriodQuantity               : Boolean;
        AllowSupplierScales                             : Boolean;
        MaxVolumeThreshold                              : Integer;
        VolumeScaleEnabled                              : Boolean;
        AclId                                           : Double;
        CreatedDate                                     : String(25);
        Contract                                        : types.contract;
        SourceSystem                                    : types.sourceSystem;
        //////
}
