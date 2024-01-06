/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 11-13-2022
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class showErrorOnChinaHandler {
    @auraEnabled (cacheable=true)
    public static boolean getCountry(Id countryId){
        boolean isChina = false;
        List<Account> acc = [SELECT Id, Country__r.Name FROM Account WHERE Country__c =: CountryId];
        for(Account a : acc){
            if(a.Country__r.Name == 'China'){
                isChina = true;
            }
            else{
                isChina = false;
            }
        }
        return isChina;
    }
}