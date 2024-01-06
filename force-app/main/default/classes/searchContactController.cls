public with sharing class searchContactController {
    @AuraEnabled
    public static List<Contact> getContact(string conName){
        List<Contact> conList = new List<contact>();    
        conList = Database.query('Select Id, Name From contact where Name LIKE \'%'+conName+'%\'');
        return conList;    
    }
    }