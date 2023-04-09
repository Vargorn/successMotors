public with sharing class ProductsModalController {
    
    @AuraEnabled
    public static List<OpportunityLineItem> getOpportunityProducts( String oppId ) {
        return ProductsModalModel.getOpprtunityProductsByOppId(oppId);
    }
}
