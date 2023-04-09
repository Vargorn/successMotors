@isTest
public with sharing class AccountOpportunityControllerTest {
    
    @isTest
    static void getOpportunitiesTest() {
        
        Account accRecord = new Account(Name = 'John');
        insert accRecord;
        Opportunity opp = new Opportunity(Name = 'Test', AccountId = accRecord.Id, CloseDate = Date.newinstance(2023, 07, 30), StageName = 'Closed Won');
        insert opp;
        Account acc = [SELECT Id FROM Account LIMIT 1];

        List<Opportunity> listOpp = AccountOpportunityController.getOpportunities(acc.Id);
        System.equals(acc.Id, listOpp[0].AccountId);
    }

}
