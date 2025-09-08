namespace sap.ariba;
using { managed } from '@sap/cds/common';
using sap.ariba.type as types from '../../types';

/**
  Name:        User Ability Fact
  Class Name:  ariba.analytics.fact.UserAbility
  Description: Analytical Fact - User Ability
*/

entity UserAbilityFact : managed, types.customFields {

  key Realm            : String(50);
  key UserData         : types.userdata;

      TimeCreated      : DateTime;
      TimeUpdated      : DateTime;

      SourceSystem     : types.sourceSystem;
      LastLoginDate    : DateTime;

      SourcingUser     : Boolean;
      ContractsUser    : Boolean;
      SPMUser          : Boolean;

      HasCreateInternalContractWorkspaceAbility    : Boolean;
      HasCreateSalesContractWorkspaceAbility       : Boolean;
      HasCreateProcurementContractWorkspaceAbility : Boolean;
      HasCreateSalesContractRequestAbility         : Boolean;
      HasCreateSourcingProjectAbility              : Boolean;
      HasCreateSPMProjectAbility                   : Boolean;
      HasCreateSupplierProjectAbility              : Boolean;
      HasCreateSQMProjectAbility                   : Boolean;

      UserCount        : Integer;
}
