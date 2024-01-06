@isTest
public class LeadProcessorTest {

    @isTest
    static void Test(){
        List<lead> leadList = new List<lead>();
        for(Integer i =0; i<200; i++){
            Lead l = new Lead();
            l.LastName = 'Test';
            l.Company = 'Test Company';
            leadList.add(l);
        }
        insert leadList;
		Test.startTest();
        LeadProcessor ld = new LeadProcessor();
        Id batchId = Database.executeBatch(ld);
        Test.stopTest();
        for(lead l : leadList){
            System.assertEquals(l.LeadSource,'Dreamforce');
        }
        
    }
}