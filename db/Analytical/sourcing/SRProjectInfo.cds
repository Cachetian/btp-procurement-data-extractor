namespace sap.ariba;
using { managed } from '@sap/cds/common';
using sap.ariba.type as types from '../../types';

/**
  Name:        Sourcing Request Project Info
  Class Name:  ariba.analytics.dimension.SRProjectInfo
  Description: Analytical Dimension - SR Project Info
*/

entity SRProjectInfo : managed, types.customFields {

  key Realm                   : String(50);
  key ProjectId               : String(50);

      TimeCreated             : DateTime;
      TimeUpdated             : DateTime;

      SourceSystem            : types.sourceSystem;
      EngagementRequestStatus : String(50);

      IssuePrimarySourceId    : String(100);
      IssueSecondarySourceId  : String(100);

      LiveERVersion           : Integer;
      InChangeRequest         : Boolean;

      IsRiskLiable            : Boolean;
      ResidualRisk            : Double;
      InherentRiskRating      : String(50);

      SourceProject           : String(255);
      SourceProjectId         : String(50);

      AclId                   : Integer;
}
