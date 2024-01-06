public with sharing class AccountAndContactWrapper {
    public class wrapperClass{
        @AuraEnabled
        public list<Account> accList;

        @AuraEnabled
        public list<Contact> conList;
    }
    @AuraEnabled
    public static wrapperClass getAccountsAndContacts(String accName){
        String key = '%'+accName+'%';
        List<Account> accountList = [SELECT Id, Name FROM Account WHERE Name LIKE : key];
        Set<Id> accIdSet = new Set<Id>();
        for(Account acc : accountList){
            accIdSet.add(acc.Id);
        }
        List<Contact> contactList = [SELECT Id, Name FROM Contact WHERE AccountId IN : accIdSet];

        wrapperClass obj = new wrapperClass();
        obj.accList = accountList;
        obj.conList = contactList;

        return obj;
    }
}