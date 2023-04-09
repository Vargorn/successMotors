@isTest
public with sharing class TotalInvoiceControllerTest {

    @TestSetup
    static void makeData(){
        Opportunity opportunity = new Opportunity(Name = 'Test', CloseDate = Date.newinstance(2022, 07, 30), StageName = 'Closed Won');
        insert opportunity;
    }
    
    @isTest
    static void getOpportunityTest() {
        Opportunity opp = [SELECT Id FROM Opportunity LIMIT 1];
        String oppId = (String) opp.Id;
        test.startTest();
          TotalInvoiceController controller=new TotalInvoiceController();
          controller.getOpportunity();
        test.stopTest();
    }
    @isTest
    static void getContactTest() {
        Opportunity opp = [SELECT Id FROM Opportunity LIMIT 1];
        String oppId = (String) opp.Id;
        test.startTest();
          TotalInvoiceController controller=new TotalInvoiceController();
          controller.getContact();
        test.stopTest();
    }
    @isTest
    static void getProductsTest() {
        Opportunity opp = [SELECT Id FROM Opportunity LIMIT 1];
        String oppId = (String) opp.Id;
        test.startTest();
          TotalInvoiceController controller=new TotalInvoiceController();
          controller.getProducts();
        test.stopTest();
    }
}
