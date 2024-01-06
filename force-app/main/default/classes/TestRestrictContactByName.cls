@isTest
public class TestRestrictContactByName {

    @isTest
    static void Test1(){
        Contact c = new Contact();
        c.LastName = 'INVALIDNAME';
        Test.startTest();
        Database.SaveResult result = Database.insert(c, True);
        Test.stopTest();
        system.assertEquals('The Last Name is not allowed for DML', result.getErrors()[0].getMessage());
    }
}