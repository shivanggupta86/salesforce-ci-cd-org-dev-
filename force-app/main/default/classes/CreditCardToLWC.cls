public with sharing class CreditCardToLWC {
    @AuraEnabled (cacheable = True)
    public static List<Credit_Card__c> getCreditCards(){
        List<Credit_Card__c> creditCardList = [SELECT Id, Name, Picture_URL__c, KnowMore_URL__c FROM Credit_Card__c];
        return creditCardList;
    }
}