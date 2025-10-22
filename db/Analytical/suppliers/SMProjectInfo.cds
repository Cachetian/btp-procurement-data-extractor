namespace sap.ariba;
using { managed, cuid } from '@sap/cds/common';
using sap.ariba.type as types from '../../types';

/**
    Name:           Supplier Management Project Info
    Class Name:     ariba.analytics.dimension.SMProjectInfo
    Description:    Supplier Management Project Info Dimension (Supplier)
    Database Table Name: DIM_SM_PROJECT_INFO
*/
entity SMProjectInfo_AN : managed, types.customFields {
    key Realm                   : String(50);
    key ProjectId               : String(50);

    TimeCreated    : DateTime;
    TimeUpdated    : DateTime;
   
    SourceSystem   : types.sourceSystem;

    LegalApprovalLevel          : Integer;
    FinanceApprovalLevel        : Integer;
    QualityApprovalLevel        : Integer;
    SustainabilityApprovalLevel : Integer;
    PurchasingApprovalLevel     : Integer;
    LOBApprovalLevel            : Integer;

    RiskScore                   : Integer;
    CommodityLevelsMax          : Integer;
    CommodityLevelsMin          : Integer;
    IsLegacy                    : Boolean;
}
