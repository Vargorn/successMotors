public with sharing class EmailController {
    @AuraEnabled
    public static EmailTemplate getEmailTemplate( String tempApiName ){
        return EmailModel.getEmailTemplateByApiName(tempApiName);
    }

    @AuraEnabled
    public static EmailTemplate getClonedEmailTemplate( String tempApiName ){
        return EmailModel.getEmailTemplateByApiName(tempApiName);
    }
    
    @AuraEnabled
    public static void cloneEmailTemplate(String tempApiName, String clonedTempApiName ){
        EmailTemplate defaultEmailTemplate =  EmailModel.getEmailTemplateByApiName(tempApiName);
        EmailTemplate newEmailTemplate = new EmailTemplate( Name = 'New Email Template',
                                                            TemplateType = 'text',
                                                            isActive = true,
                                                            FolderId = defaultEmailTemplate.FolderId,
                                                            DeveloperName = clonedTempApiName,
                                                            Subject = defaultEmailTemplate.Subject,
                                                            Body = defaultEmailTemplate.Body);
        insert newEmailTemplate;
    }

    @AuraEnabled
    public static void updateEmailTemplateFields( String tempApiName, String oppInvNumber, String changedEmailTempBody ){
        EmailTemplate temp = EmailModel.getEmailTemplateByApiName(tempApiName);
        temp.Subject = oppInvNumber;
        temp.Body = changedEmailTempBody;
        update temp;
    }

    @AuraEnabled
    public static void deleteClonedEmailTemplate( String tempApiName ){
        EmailTemplate newEmailTemplate = EmailModel.getEmailTemplateByApiName(tempApiName);
        delete newEmailTemplate;
    }

    @AuraEnabled
    public static OpportunityContactRole getOpportunityContRole( String oppId ) {
        return EmailModel.getOppContRoleByOppId(oppId);
    }

    @AuraEnabled
    public static Opportunity getInvoicePDFInfo( String oppId ) {
        return EmailModel.getInvoicePDFInfoByOppId(oppId);
    }
    @AuraEnabled
    public static Organization getOrganizationName() {
        return [SELECT Id, Name FROM Organization];
    }
}
