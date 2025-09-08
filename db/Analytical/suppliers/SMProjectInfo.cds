namespace sap.ariba;
using { managed } from '@sap/cds/common';

using sap.ariba.type as types from '../../types';

/**
    Name:          Supplier Management Project Info
    Class Name:    ariba.analytics.dimension.SMProjectInfo
    Description:   Supplier Management Project Info Dimension
*/

entity SMProjectInfo : managed {

    key Realm                   : String(50);
    key ProjectId               : String(50);

        SourceSystem            : types.sourceSystem;

        LegalApprovalLevel          : String(50);
        FinanceApprovalLevel        : String(50);
        QualityApprovalLevel        : String(50);
        SustainabilityApprovalLevel : String(50);
        PurchasingApprovalLevel     : String(50);
        LOBApprovalLevel            : String(50);

        RiskScore               : Double;
        CommodityLevelsMax      : Integer;
        CommodityLevelsMin      : Integer;

        IsLegacy                : Boolean;
}
