public with sharing class TotalInvoiceController {

    private String opportunityId;

    public TotalInvoiceController() {
        opportunityId = Apexpages.currentPage().getParameters().get('opportunity');
    }

    public List<Opportunity> getOpportunity() {
        List<Opportunity> opportunity = TotalInvoiceModel.getOpportunityById(opportunityId);
        return opportunity;
    }
    
    public List<OpportunityContactRole> getContact() {
        List<OpportunityContactRole> contact = TotalInvoiceModel.getContactById(opportunityId);
        return contact;
    }
    
    public List<OpportunityLineItem> getProducts() {
        List<OpportunityLineItem> products = TotalInvoiceModel.getProductsById(opportunityId);
        return products;
    }
}
