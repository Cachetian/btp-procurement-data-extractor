namespace sap.ariba;
using { managed } from '@sap/cds/common';
using sap.ariba.type as types from '../../types';

/**
  Name:        User Ability Fact
  Class Name:  ariba.analytics.fact.UserAbility
  Description: Analytical Fact - User Ability (General)
  Database Table Name: FACT_USER_ABILITY
*/
entity UserAbilityFact_AN : managed, types.customFields {

  key Realm                  : String(50);
  key UserDataUserId         : String(50);
  key UserDataSourceSystem : String(100);
  key SourceSystemId         : String(100);


      LoadCreateTime : DateTime;
      LoadUpdateTime : DateTime;
      TimeCreated    : DateTime;
      TimeUpdated    : DateTime;
      
      UserData       : types.user;
      SourceSystem   : types.sourceSystem;
      LastLoginDate  : types.day;

      SourcingUser   : Boolean;
      ContractsUser  : Boolean;
      SPMUser        : Boolean;

      HasCreateInternalContractWorkspaceAbility    : Boolean;
      HasCreateSalesContractWorkspaceAbility       : Boolean;
      HasCreateProcurementContractWorkspaceAbility : Boolean;
      HasCreateSalesContractRequestAbility         : Boolean;
      HasCreateSourcingProjectAbility              : Boolean;
      HasCreateSPMProjectAbility                   : Boolean;
      HasCreateSupplierProjectAbility              : Boolean;
      HasCreateSQMProjectAbility                   : Boolean;

      UserCount      : Integer;
}
