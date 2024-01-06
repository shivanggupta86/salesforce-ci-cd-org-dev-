@isTest
public class AccountProcessorTest {
    
    @isTest
    static void TestcountContacts(){
        Account acc = new Account();
        acc.Name = 'Test';
        insert acc;
        Contact con = new Contact();
        con.LastName = acc.Name;
        insert con;
        List<Id> accList = new List<Id>();
        accList.add(acc.id);
        Test.startTest();
        AccountProcessor.countContacts(accList);
        Test.stopTest();
        System.assertEquals(1,acc.Number_Of_Contacts__c);
        
    }
}