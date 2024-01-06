public with sharing class ContactPaginationHandler {
    
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(){
        try {
            return [SELECT Name FROM Contact Limit 20];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}