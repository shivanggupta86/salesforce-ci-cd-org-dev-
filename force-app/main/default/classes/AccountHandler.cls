public with sharing class AccountHandler {
    
    /* Automatically Close Opportunities with probability greater than 70% when Eligible checkbox checked on Account */
    public static void closeOpportunity(List<Account> accList, Map<Id, Account> oldMap) {
        if(accList.size() > 0){
            Set<Id> accIdSet = new Set<Id>();
            for(Account acc : accList){
                if(acc.Eligible__c){
					accIdSet.add(acc.Id);
                }
            }
            
            if(accIdSet.size() > 0){
                List<Opportunity> oppList = [SELECT StageName FROM Opportunity WHERE AccountId IN : accIdSet];
                if(oppList.size() > 0){
                    for(Opportunity opp : oppList){
                        opp.StageName = 'Closed Won';
                    }
                }
                if(oppList.size() > 0){
                    update oppList;
                }
            }
        }
          
    }
    
    
    /* On Account update, Update the parent account field with the Opportunity name that has the Highest Amount */
    public static void updateParentAccountWithHighestOpportunity(List<Account> newAccounts){
        if(newAccounts.size() > 0){
            Set<Id> accIdSet = new Set<Id>();
            for(Account acc : newAccounts){
                accIdSet.add(acc.Id);
            }
            
            if(accIdSet.size() > 0){
                List<Account> accList = [SELECT Site, (SELECT Name FROM Opportunities ORDER BY Amount DESC LIMIT 1) FROM Account WHERE Id IN : accIdSet];
                if(accList.size() > 0){
                    for(Account acc : accList){
                        if(acc.Opportunities.size() > 0){
                            acc.Site = acc.Opportunities[0].Name;
                        }
                    }
                }
            }       
        }
    }
    
    /*When account rating is updated, update it's name with the name of it's 3rd contact*/
    public static void updateAccountNameWithThirdContactName(List<Account> newAccounts, Map<Id, Account> oldMap){
        
    }
    
    /* Whenever a Account is inserted create a related contact and add that related contact in the ClientContact__c field on Account */
    public static void insertContactInClientContact(List<Account> newAccounts){
        
        
    }

    /* Trigger 30 : When account status changes from Active to inactive delete all the related opportunities other that closed won and Mark DoNotContact field as check on contact object */
    public static void deleteOpportunities(List<Account> accList, Map<Id, Account> oldMap){
        
    }
}