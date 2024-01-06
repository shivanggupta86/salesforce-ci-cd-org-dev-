public with sharing class apexWireController {
    @auraEnabled(cacheable = true)
    public static List<Account> getAccounts() {
        return [SELECT Id, Name , Phone, Type From Account LIMIT 5];
    }

    @auraEnabled(cacheable = true)
    public static List<Account> getfilteredAccountsByType(string type ) {
        return [SELECT Name , Phone, Type From Account WHERE Type =: type LIMIT 8];
    }

    @auraEnabled(cacheable = true)
    public static List<Account> getAllaccounts(string accName ) {
        string key = '%' + accName + '%';
        return [SELECT Id, Name , Phone, Website From Account WHERE Name LIKE: key];
    }

}