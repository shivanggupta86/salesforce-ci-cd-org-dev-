@isTest
public class AddPrimaryContactTest {

    @isTest
    static void testQueueable(){
        List<Account> testAccount = new List<Account>();
        for(Integer i =0; i<50; i++){
            testAccount.add(new Account(Name ='Account'+i, BillingState ='CA'));
        }
        for(Integer j=0; j<50; j++){
            testAccount.add(new Account(Name ='Account'+j,BillingState ='CA'));
        }
        insert testAccount;
        
        contact con = new contact(firstName ='John',LastName = 'Doe');
        insert con;
        addPrimaryContact addit = new addPrimaryContact(con, 'CA');
        Test.startTest();
        system.enqueueJob(addit);
        Test.stopTest();
        system.assertEquals(50,[SELECT Count() FROM Contact WHERE AccountId IN (SELECT id FROM Account WHERE BIllingState = 'CA')]);
    }
}