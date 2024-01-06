public with sharing class RecordPickerDemoHandler {
    
    @AuraEnabled(cacheable=true)
    public static List<Contact> getRelatedContacts(String recordId){
        List<Contact> relatedContacts = [SELECT Name, Phone, Email FROM Contact WHERE AccountId =: recordId];
        return relatedContacts;
    }
}