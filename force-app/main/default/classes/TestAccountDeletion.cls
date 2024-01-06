@isTest
public class TestAccountDeletion {

    @isTest
    static void TestingDeletion(){
        Account acc = new Account();
        acc.name = 'Test';
        insert acc;
        Opportunity opp = new Opportunity();
        opp.Name = acc.name;
        opp.AccountId = acc.id;
        opp.CloseDate = System.today();
        opp.StageName = 'Closed Lost';
        insert opp;
        
        Test.startTest();
        Database.DeleteResult result = Database.delete(acc, false);
        Test.stopTest();
        
        // Verify 
        // In this case the deletion should have been stopped by the trigger,
        // so verify that we got back an error.
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
        System.assertEquals('Cannot delete account with related opportunities.',
                             result.getErrors()[0].getMessage());
    }
}