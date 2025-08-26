namespace sap.ariba;
using { managed,cuid } from '@sap/cds/common';

using sap.ariba.type as types from '../types';
/**
    Name:	Sales Contract Workspace (Procurement)
    Class Name:	ariba.analytics.fact.GeneralContractWorkspace
    Description:	Contract Workspace (Procurement)
    Database Table Name:	FACT_GENERAL_CONTRACT_WORKSPACE
*/
entity GeneralContractWorkspace: managed,types.customFields  {
    key ProjectId                       : String(50);
    key Realm                           : String(50);
        LoadCreateTime                  : DateTime;
        LoadUpdateTime                  : DateTime;
        Description                     : String(3000);
        AclId                           : Double;
        Duration                        : Double;
        BeginDate                       : types.day;
        DueDate                         : types.day;
        EndDate                         : types.day;
        Status                          : String(90);
        State                           : String(60);
        OnTimeOrLate                    : String(30);
        Owner                           : types.contact;
        ProjectInfo                     : types.projectInfo;
        DependsOnProject                : types.projectInfo;
        ContainerProject                : types.projectInfo;
        Process                         : types.process;
        IsTestProject                   : Boolean;
        SourceSystem                    : types.sourceSystem;
        ProcessStatus                   : String(50);
        Contract                        : types.contract;
        HierarchyType                   : String(75);
        Supplier                        : types.supplier;
        ContractId                      : String(150);
        DocumentVersion                 : String(30);
        ParentAgreement                 : types.projectInfo;
        ContractStatus                  : String(75);
        AmendmentReason                 : String(75);
        AmendmentVersion                : String(15);
        Amount                          : Double;
        ContractCurrency                : String(90);
        ProposedAmount                  : Double;
        OrigProposedAmount              : Double;
        OrigAmount                      : Double;
        EffectiveDate                   : types.day;
        ExpirationDate                  : types.day;
        AgreementDate                   : types.day;
        IsEvergreen                     : Boolean;
        RelatedId                       : String(90);
        AutoRenewalInterval             : Double;
        MaxAutoRenewalsAllowed          : Double;
        AutoRenewalCount                : Double;
        ExpirationTermType              : String(150);
        NoticePeriod                    : Double;
        LastPublishedDate               : types.day;

        Commodity                       : Composition of many ContractWorkspaces_Commodity on Commodity.ContractWorkspace = $self;
        Organization                    : Composition of many ContractWorkspaces_Organization on Organization.ContractWorkspace = $self;
        Region                          : Composition of many ContractWorkspaces_Region on Region.ContractWorkspace = $self;
        AffectedParties                 : Composition of many ContractWorkspaces_AffectedParties on AffectedParties.ContractWorkspace = $self;
        AllOwners                       : Composition of many ContractWorkspaces_AllOwners on AllOwners.ContractWorkspace = $self;

}

entity ContractWorkspaces_Commodity:  cuid  {
    Commodity                           : types.commodity;
    ContractWorkspace                   : Association to ContractWorkspaces;
}

entity ContractWorkspaces_Organization:  cuid  {
    Organization                        : types.organization;
    ContractWorkspace                   : Association to ContractWorkspaces;
}

entity ContractWorkspaces_Region:  cuid  {
    Region                              : types.region;
    ContractWorkspace                   : Association to ContractWorkspaces;
}

entity ContractWorkspaces_AffectedParties:  cuid  {
    AffectedParties                     : types.supplier;
    ContractWorkspace                   : Association to ContractWorkspaces;
}

entity ContractWorkspaces_AllOwners:  cuid  {
    AllOwners                           : types.contact;
    ContractWorkspace                   : Association to ContractWorkspaces;
}