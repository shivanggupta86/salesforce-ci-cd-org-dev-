public with sharing class wireAdapterCreateRecordController {
    
    @AuraEnabled(cacheable = true)
    public static String getAccountId(string accName){
        string accId;
        List<Account> accList = new List<Account>();
        accList = Database.query('SELECT Id, Name FROM Account WHERE Name LIKE \'%'+accName+'%\'');
        for(Account acc : accList){
            accId = acc.Id;
        }
        system.debug(accId);
        return accId;
    }
}