namespace sap.ariba;
using { managed } from '@sap/cds/common';

using sap.ariba.type as types from '../../types';


/**
    Name:	                Collaboration Request (Procurement & Invoicing)
    Class Name:	            ariba.analytics.fact.CollaborationRequest
    Description:	        Collaboration Request
    Database Table Name:	FACT_COLLABORATION_REQUEST

*/

entity CollaborationRequest_AN: managed,types.customFields  {
    key Realm                               : String(50);
    key CollaborationRequestId              : String(75);
    key CRLineNumber                        : Integer;
    
        RequisitionLineNumber                 : Integer;
        TimeCreated                           : DateTime;
        TimeUpdated                           : DateTime;
        LoadCreateTime                        : DateTime;
        LoadUpdateTime                        : DateTime;
        RequisitionId                         : String(75);
        Requisition                           : String(765);
        AmountProposed                        : Double;
        ResponseTime                          : Double;
        CollaborationTime                     : Double;
        Supplier                              : types.supplier;
        Status                                : String(150);
        Response                              : String(75);
        SubmitDate                            : types.day;
        ResponseDate                          : types.day;
        CompletedDate                         : types.day;
        Commodity                             : types.commodity;
        ERPCommodity                          : types.erpCommodity;
        SourceSystem                          : types.sourceSystem;
        CollaborationItemType                 : String(150);
        OriginalItemSupplier                  : String(765);
        RequestedRate                         : Double;
        RequestedBillRate                     : Double;
        RequestedPayRate                      : Double;
        ExpenseAmount                         : Double;
        CurrentSupplierResponse               : String(75);
        Requester                             : types.contact;
        RequestType                           : String(75);
        Quantity                              : Double;
        UnitOfMeasure                         : types.uom;
        ServiceCategoryDetail                 : types.serviceCategoryDefinition;
        Part                                  : types.part;
        NonCatalogSupplierPartNumber          : String(765);
        NonCatalogSupplierPartAuxiliaryId     : String(765);
        DeclineReason                         : String(765);
        CancelReason                          : String(765);
        AssociatedCollaborationRequestId      : String(75);
        StartDate                             : types.day;
        EndDate                               : types.day;
        WorkLocation                          : types.location;
}
