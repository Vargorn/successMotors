public with sharing class TotalInvoiceNumHandler {
    
    public static void setParamsForContentVersion( ContentVersion contVers, String invNum, Blob pdf ) {
        contVers.Title = invNum;
        contVers.VersionData = pdf;
        contVers.PathOnClient = invNum + '.pdf';
    }
}





