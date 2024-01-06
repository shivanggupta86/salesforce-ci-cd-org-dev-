public with sharing class ContactHandler {
    
    /* Prevent duplication of Contact record if it's phone and email are same */
    public static void preventDuplicationOfContact(List<Contact> newContacts, Map<Id, Contact> oldMap){
        Map<String, Contact> conMap = new Map<String, Contact>();
        if(newContacts.size() > 0){
            Map<String, Contact> existingContact = new Map<String, Contact>();
            for(Contact con : [SELECT Id, email, phone, amount__c FROM Contact WHERE email != NULL AND phone != NULL]){
                existingContact.put(con.Email+'-'+con.Phone+'-'+String.valueOf(con.amount__c), con);
            }
            
            for(Contact con : newContacts){
                if(existingContact.containsKey(con.email+'-'+con.Phone+'-'+String.valueOf(con.amount__c))){
                    con.addError('Contact already exists');
                }
            }
        }
    }
    
    /* Trigger 33 : On Contact insertion update the Type field on Contact same as the Record Type of Account. If user tries to update Type field other than the account's record type throw error.
*/
    public static void checkAccountRecordType(List<Contact> conList, Map<Id, Contact> oldMap){
        
    }
    
    /* RollUp Summary */
    public static void rollUpSummary(List<Contact> conList, Map<Id, Contact> oldMap){
        if(conList.size() > 0){
            Set<Id> accId = new Set<Id>();
            for(Contact con : conList){
                if(oldMap != NULL){
                    if(con.AccountId != oldMap.get(con.Id).AccountId){
                        accId.add(con.AccountId);
                        accId.add(oldMap.get(con.Id).AccountId);
                    }else{
                        accId.add(con.AccountId);
                    }
                }else{
                    accId.add(con.AccountId);
                }
            }
            Map<Id, Double> accMap = new Map<Id, Double>();
            for(AggregateResult agg : [SELECT Count(Id) sum, AccountId FROM Contact WHERE AccountId IN : accId GROUP BY AccountId]){
                Double totalContacts = (Double)agg.get('sum');
                Id accountId = (Id)agg.get('accountId');
                accMap.put(accountId, totalContacts);
            }
            List<Account> accList = new List<Account>();
            for(Id i : accMap.keySet()){
                Account acc = new Account();
                acc.Id = i;
                acc.Number_Of_Contacts__c = accMap.get(i);
               	accList.add(acc);
            }
            update accList;
        }
        
    }
}