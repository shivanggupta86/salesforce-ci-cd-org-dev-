@RestResource(urlMapping='/Accounts/*/contacts')
global with sharing class AccountManager {
    @HttpGet
    global static Account getAccount() {
        RestRequest request = RestContext.request;
        // grab the caseId from the end of the URL
        String AccountId = request.requestURI.substringBetween('Accounts/','/contacts');
        Account result =  [SELECT id, Name,(SELECT id, Name FROM Contacts) FROM Account WHERE Id =: accountid];
        return result;
    }
}