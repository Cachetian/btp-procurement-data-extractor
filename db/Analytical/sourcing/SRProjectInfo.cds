namespace sap.ariba;
using { managed, cuid } from '@sap/cds/common';
using sap.ariba.type as types from '../../types';

/**
    Name:           Sourcing Request Project Info
    Class Name:     ariba.analytics.dimension.SRProjectInfo
    Description:    Sourcing Request Project Info Dimension (Sourcing)
    Database Table Name: DIM_SR_PROJECT_INFO
*/
entity SRProjectInfo_AN : managed, types.customFields {
    key Realm                   : String(50);
    key ProjectId               : String(50);

    
    TimeCreated                 : DateTime;
    TimeUpdated                 : DateTime;
    SourceSystem                : String(100);
    EngagementRequestStatus     : String(60);
    IssuePrimarySourceId        : String(50);
    IssueSecondarySourceId      : String(50);

    LiveERVersion               : Integer;
    InChangeRequest             : Boolean;
    IsRiskLiable                : Boolean;
    ResidualRisk                : String(100);
    InherentRiskRating          : String(100);
    SourceProject               : String(50);
    SourceProjectId             : String(50);
    AclId                       : Double;
}