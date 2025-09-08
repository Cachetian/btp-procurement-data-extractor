namespace sap.ariba;
using { managed, cuid } from '@sap/cds/common';
using sap.ariba.type as types from '../../types';

/**
  Name:        Sourcing Request Projects
  Class Name:  ariba.analytics.fact.SRProjects
  Description: Analytical Fact - Sourcing Request Projects
*/

entity SRProjects : managed, types.customFields {

  key Realm              : String(50);
  key ProjectId          : String(50);

      TimeCreated        : DateTime;
      TimeUpdated        : DateTime;

      Description        : String(1000);
      AclId              : Integer;
      Duration           : Double;

      BeginDate          : types.singleDate;
      DueDate            : types.singleDate;
      EndDate            : types.singleDate;
      EndDateTime        : DateTime;

      Status             : String(30);
      State              : String(30);
      OnTimeOrLate       : String(10);

      Owner              : types.userdata;
      ProjectInfo        : Association to SRProjectInfo;    
      DependsOnProject   : String(50);
      ContainerProject   : String(50);

      Process            : String(50);
      Commodity          : String(255);
      Organization       : String(255);
      Region             : String(255);

      IsTestProject      : Boolean;
      SourceSystem       : types.sourceSystem;
      ProcessStatus      : String(50);

      AllOwners          : Composition of many SRProjects_AllOwners on AllOwners.SRProject = $self;
      SRProjectInfo      : Association to SRProjectInfo;   

      PrLastStartDate    : types.singleDate;
      PrLastEndDate      : types.singleDate;
      PrExpectedStartDate: types.singleDate;
      PrExpectedEndDate  : types.singleDate;

      LastPrStatus       : String(30);
      SRComment          : String(1000);
}

entity SRProjects_AllOwners : cuid {
  AllOwners   : types.userdata;
  SRProject   : Association to SRProjects;
}
