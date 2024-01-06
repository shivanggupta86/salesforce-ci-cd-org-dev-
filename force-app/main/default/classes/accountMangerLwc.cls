public with sharing class accountMangerLwc {
    
    @AuraEnabled(cacheable = true)
    public static List<Account> getAccountNumber(Integer count){
        return [SELECT id, Name, Phone, Website FROM Account LIMIT : count];
    }

    @AuraEnabled(cacheable = true)
    public static List<Account> getAccountName(string accName){
        List<Account> accList = new List<Account>();
        accList = Database.query('SELECT id, Name, Phone, Website FROM Account WHERE Name LIKE \'%'+accName+'%\'');
        return accList;
    }

    @AuraEnabled(cacheable = true)
    public static List<Account> getAccountDetail(){
        return [SELECT Id, Name, Phone, Website, AnnualRevenue FROM Account];
    }
}