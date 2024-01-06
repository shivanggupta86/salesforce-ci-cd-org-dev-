public with sharing class OpportunityHandler {
    
    /* Trigger 16 :When an Opportunity inserts or it's amount updates, update the Account Site field on Account with the Name of Opportunity that has highest amount */
    public static void updateAccountSiteOnAccount(List<Opportunity> newOpps,  Map<Id, Opportunity> oldMapOpps){
        if(newOpps.size() > 0){
            Set<Id> accIdset = new Set<Id>();
            for(Opportunity opp : newOpps){
                if(oldMapOpps != NULL){
                    if(opp.AccountId != oldMapOpps.get(opp.Id).AccountId){
                        accIdSet.add(opp.AccountId);
                        accIdSet.add(oldMapOpps.get(opp.Id).AccountId);
                    }else{
                        if(opp.amount != NULL){
                            accIdSet.add(opp.AccountId);
                        }
                    }
                }else{
                    accIdSet.add(opp.AccountId);
                }
            }
            system.debug(accIdSet);
            if(accIdSet.size() > 0){
                List<Account> accList = [SELECT Id, Site, (SELECT Name, AccountId, Amount FROM Opportunities WHERE Amount != NULL ORDER BY Amount DESC LIMIT 1) FROM Account WHERE Id IN : accIdSet];
                List<Account> updateAccs = new List<Account>();
                if(accList.size() > 0){
                    for(Account acc : accList){
                        if(acc.Opportunities.size() > 0){
                            acc.Site = acc.Opportunities[0].Name;
                        }else{
                            acc.Site = '';
                        }
                        updateAccs.add(acc);
                    }
                    if(updateAccs.size() > 0){
                        update updateAccs;
                    }
                }
            }        
        }
    }

    /* When StageName is updated in Opportunity update the Opp Name in Task Description associated to the Opportunity else create a Task  */
    public static  void updateOrCreateTask(List<Opportunity> oppList, Map<Id, Opportunity> oldMap){
        if(oppList.size() > 0){
            Map<Id, String> oppMap = new Map<Id, String>();
            for(Opportunity opp : oppList){
                if(opp.StageName != oldMap.get(opp.Id).StageName){
                    oppMap.put(opp.Id, opp.Name);
                }
            }
            
            if(!oppMap.isEmpty()){
                List<Task> taskList = [SELECT Id, WhatId, Description FROM Task WHERE WhatId IN : oppMap.keySet()];
                if(taskList.size() > 0){
                    for(Task t : taskList){
                        t.Description = oppMap.get(t.WhatId);
                    }
                    if(taskList.size() > 0){
                        update taskList;
                    }
                }else{
                    List<task> newTasks = new List<Task>();
                    for(Id i : oppMap.keySet()){
                        Task t = new Task();
                        t.Description = oppMap.get(i);
                        t.WhatId = i;
                        newTasks.add(t);
                    }
                    if(newTasks.size()> 0){
                        insert newTasks;
                    }
                }
            }
        }
    }

    /* Trigger 26 : When all opportunities linked to an account are closed won, update the account status  to Closed, however if any opp is not closed won, update the account status as Open */
    public static void updateAccountStatus(List<Opportunity> oppList, Map<Id, Opportunity> oldMap){
        if(oppList.size() > 0){
            Set<Id> accIdSet = new Set<Id>();
            for(opportunity opp : oppList){
                if(oldMap != NULL && opp.StageName != NULL){
                    if(opp.AccountId != oldMap.get(opp.Id).AccountId){
                        accIdSet.add(opp.AccountId);
                        accIdSet.add(oldMap.get(opp.Id).AccountId);
                    }else{
                        accIdSet.add(opp.AccountId);
                    }
                }else{
                    accIdSet.add(opp.AccountId);
                }
            }
            if(accIdSet.size() > 0){
                List<Account> accList = [SELECT Id, AccountStatus__c, (SELECT StageName FROM Opportunities WHERE StageName != 'Closed Won') FROM Account WHERE Id IN : accIdSet];
                for(Account acc : accList){
                    if(acc.Opportunities.size() > 0){
                        acc.AccountStatus__c = 'Open';
                    }else{
                        acc.AccountStatus__c = 'Closed';
                    }
                }
                if(accList.size() > 0){
                    update accList;
                }
            }
        }
    }

    /* Trigger 27 : Update Account Rating based on Total amount related Opportunities 
        if Amount <= 50K - Cold
        if Amount <= 1 Lakh - Warm
        if Amount > 1 lakh - Hot
    */
    public static void updateAccountRating(List<Opportunity> oppList, Map<Id, Opportunity> oldMap){
        if(oppList.size() > 0){
            Set<Id> accIdSet = new Set<Id>();
            for(opportunity opp : oppList){
                if(oldMap != NULL){
                    if(opp.AccountId != oldMap.get(opp.Id).AccountId){
                        accIdSet.add(opp.AccountId);
                        accIdSet.add(oldMap.get(opp.Id).AccountId);
                    }else{
                        accIdSet.add(opp.AccountId);
                    }
                }else{
                    accIdSet.add(opp.AccountId);
                }
            }
            if(accIdSet.size() > 0){
                Map<Id, String> accIdRatingMap = new Map<Id, String>();
                for(AggregateResult agg : [SELECT Sum(Amount)total , AccountId FROM Opportunity WHERE AccountId IN : accIdSet GROUP BY AccountId]){
                    Double oppTotalAmount = (Double)agg.get('total');
                    Id accountId = (Id)agg.get('AccountId');
                    if(oppTotalAmount != NULL){
                        if(oppTotalAmount <= 50000){
                            accIdRatingMap.put(accountId, 'Cold');
                        }
                        else if(oppTotalAmount > 50000 && oppTotalAmount <= 100000){
                            accIdRatingMap.put(accountId, 'Warm');
                        }
                        else if(oppTotalAmount > 100000){
                            accIdRatingMap.put(accountId, 'Hot');
                        }
                    }
                }
                
                if(!accIdRatingMap.isEmpty()){
                    List<Account> updatedAccounts = new List<Account>();
                    for(Id i : accIdSet){
                        Account acc = new Account();
                        acc.Id = i;
                        acc.Rating = accIdRatingMap.get(i);
                        updatedAccounts.add(acc);
                    }
                    
                    if(updatedAccounts.size() > 0){
                        update updatedAccounts;
                    }
                }
            }
        }
    }

    /* Trigger 38 : Whenever the Opportunity Type is updated then insert a new contactRole according to the Opportunity Type.
    Create 1 picklist field on Contact name as Type = 'Customer', 'Partner', 'Non-profit'
        Let say OppType is Customer, then I have to update the same Type of Contact (Customer) in the contactRole that has 
        New-Customer Type.

        If a contact doesn't exist with the same type then 'display error that no contact exist with this type'.
        
        Let say Opp Type is getting updated then delete the existing Contact Role and insert the new type contact role.
    */

    public static void insertOrDeleteContactRole(List<Opportunity> oppList, Map<Id, Opportunity> oldMap){
        
    }
}