public with sharing class TotalInvoiceNumController {

    Opportunity currentOpportunity;
    Opportunity duplicateOpportunity;
    String oppId;
    String invoiceNumber;
    Id contDocId;

    public TotalInvoiceNumController(ApexPages.StandardController standartController) {
        currentOpportunity = (Opportunity) standartController.getRecord();
        oppId = currentOpportunity.Id;
        duplicateOpportunity = TotalInvoiceNumModel.getOpportunityById( oppId );
        invoiceNumber = duplicateOpportunity.Invoice_Number__c;
    }

    public Pagereference addPage() {
        Blob pdf;
        
        Pagereference totalInvoicePage = Page.TotalInvoice;
        totalInvoicePage.getParameters().put('opportunity', oppId);
        if(Test.isRunningTest()) { 
            pdf = blob.valueOf('Unit.Test');
        } else {
            pdf = totalInvoicePage.getContent();
        }
        
        List<ContentVersion> contentList = TotalInvoiceNumModel.getContentByInvoiceNum( invoiceNumber );
        ContentVersion contVers = new ContentVersion();
        
        if (contentList.isEmpty()) {
            TotalInvoiceNumHandler.setParamsForContentVersion(contVers, invoiceNumber, pdf);
            insert contVers;

            contDocId = TotalInvoiceNumModel.getIdContentByContentVersion( contVers );
            ContentDocumentLink contDocLink = new ContentDocumentLink();
            contDocLink.ContentDocumentId = contDocId;
            contDocLink.ShareType = 'V';
            contDocLink.LinkedEntityId = oppId;
            insert contDocLink;
        } else {
            contDocId = contentList[0].ContentDocumentId;
            ContentDocument cont = [SELECT Id, Title, ContentSize FROM ContentDocument WHERE Id =: contDocId];
            delete cont;

            TotalInvoiceNumHandler.setParamsForContentVersion(contVers, invoiceNumber, pdf);
            insert contVers;

            contDocId = TotalInvoiceNumModel.getIdContentByContentVersion( contVers );
            ContentDocumentLink contDocLink = new ContentDocumentLink();
            contDocLink.ContentDocumentId = contDocId;
            contDocLink.ShareType = 'V';
            contDocLink.LinkedEntityId = oppId;
            insert contDocLink;
        }
        PageReference pageRef = new ApexPages.StandardController(currentOpportunity).view();
        pageRef.setRedirect(true);
        return pageRef;
    }
}
