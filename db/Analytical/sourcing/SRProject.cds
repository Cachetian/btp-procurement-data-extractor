namespace sap.ariba;
using { managed, cuid } from '@sap/cds/common';
using sap.ariba.type as types from '../../types';

/**
    Name:           Sourcing Request Project
    Class Name:     ariba.analytics.fact.SRProject
    Description:    Sourcing Request Project Fact (Sourcing)
    Database Table Name: FACT_SR_PROJECT
*/
entity SRProject_AN : managed, types.customFields {
    key Realm                   : String(50);
    key ProjectId               : String(50);

    
    TimeCreated                 : DateTime;
    TimeUpdated                 : DateTime;
    LoadCreateTime              : DateTime;
    LoadUpdateTime              : DateTime;
    
    Description                 : String(3000);
    Status                      : String(90);
    State                       : String(60);
    OnTimeOrLate                : String(60);
    Owner                       : types.owner;
    SourceSystem                : types.sourceSystem;

    Supplier                    : types.supplier;
    Process                     : types.process;
    ProjectInfo                 : types.projectInfo;
    DependsOnProject            : types.projectInfo;
    ContainerProject            : types.projectInfo;
    SRProjectInfo               : types.srProjectInfo;

    BeginDate                   : types.day;
    DueDate                     : types.day;
    EndDate                     : types.day;
    EndDateTime                 : types.day;
    PrLastStartDate             : types.day;
    PrLastEndDate               : types.day;
    PrExpectedStartDate         : types.day;
    PrExpectedEndDate           : types.day;

    Duration                    : Decimal(18,6);
    AclId                       : Integer;
    ProcessStatus               : String(90);
    LastPrStatus                : String(90);
    IsTestProject               : Boolean;

    // Associations
    Commodity                   : Composition of many SRProject_Commodity_AN on Commodity.SRProject = $self;
    Organization                : Composition of many SRProject_Organization_AN on Organization.SRProject = $self;
    Region                      : Composition of many SRProject_Region_AN on Region.SRProject = $self;
    AllOwners                   : Composition of many SRProject_AllOwners_AN on AllOwners.SRProject = $self;
}

entity SRProject_Commodity_AN : cuid {
    Commodity   : types.commodity;
    SRProject   : Association to SRProject_AN;
}

entity SRProject_Organization_AN : cuid {
    Organization : types.organization;
    SRProject    : Association to SRProject_AN;
}

entity SRProject_Region_AN : cuid {
    Region      : types.region;
    SRProject   : Association to SRProject_AN;
}

entity SRProject_AllOwners_AN : cuid {
    AllOwners   : types.user;
    SRProject   : Association to SRProject_AN;
}
