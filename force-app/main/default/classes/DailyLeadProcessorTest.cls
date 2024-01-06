@isTest
private class DailyLeadProcessorTest {
    
    public static string CRON_EXP = '0 0 0 16 5 ? 2022';
    @isTest
    static void TestLead(){
        List<lead> leadList = new List<lead>();
        for(integer i = 0; i<200; i++){
            Lead l = new lead(FirstName = 'First' +i, LastName = 'lastName', Company = 'The Inc');
            leadList.add(l);
        }
        
        insert leadList;
        Test.startTest();
        string jobId = system.schedule('ScheduledApexTest', CRON_EXP, new DailyLeadProcessor());
        Test.stopTest();
        
        List<lead> checkLead = new List<lead>();
        checkLead = [SELECT id FROM lead WHERE LeadSource = 'Dreamforce' and Company = 'The Inc'];
        system.assertEquals(200, checklead.size(),'leads were not created');
    }
    
}