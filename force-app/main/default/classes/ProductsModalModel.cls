public with sharing class ProductsModalModel {
    
    public static List<OpportunityLineItem> getOpprtunityProductsByOppId( String oppId ) {
        return [SELECT Id, OpportunityId, UnitPrice, TotalPrice, Opportunity.TotalOpportunityQuantity, PricebookEntry.Name, PricebookEntry.UnitPrice 
                FROM OpportunityLineItem 
                WHERE OpportunityId =: oppId];
    }
}
