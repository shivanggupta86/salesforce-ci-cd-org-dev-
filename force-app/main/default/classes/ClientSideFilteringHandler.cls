public with sharing class ClientSideFilteringHandler {
    
    @AuraEnabled (cacheable=true)
    public static List<Contact> getContacts(){
        try {
            return [SELECT Id, Name, Title, Email FROM Contact Limit 10];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}