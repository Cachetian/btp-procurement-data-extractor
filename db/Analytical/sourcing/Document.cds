namespace sap.ariba;
using { managed, cuid } from '@sap/cds/common';

using sap.ariba.type as types from '../../types';

/**
    Name:	Project
    Class Name:	ariba.analytics.fact.Document
    Description:	Document
    Database Table Name:	FACT_DOCUMENT
*/

entity Document_AN: managed,types.customFields   {
    key Realm                               : String(50);
    key InternalId                          : String(150);
    TimeCreated                             : DateTime;
    Status                                  : String(90);
    Description                             : String(4000);
    DocumentType                            : String(150);
    Title                                   : String(259);
    TimeUpdated                             : DateTime;
    ProjectInfo                             : types.projectInfo;
    CreateDate                              : types.day;
}