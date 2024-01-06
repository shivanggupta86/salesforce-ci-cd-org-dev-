public with sharing class CaseHandler {
    
    /*** Trigger : 31
        When is inserted/updated/deleted/Undelete, update the account rating based on the number of closed cases it has :
        if closed case < 2 then rating = Cold
        if closed case > 2 then rating = Hot
        if closed case > 5 then rating = warm
    ***/

    public static void updateAccountRating(List<Case> newCases, Map<Id, Case> oldMap){

        
    }

    /* Calculate Number of Cases based it's status (New, Waiting, Escalated each) on each account and update Accounts field
        1. Number of new Cases
        2. Number of waiting Cases
        3. Number of escalated Cases
    */
    public static void calculateCases(List<Case> caseList, Map<Id, Case> oldMap){
        
    }

    /* Trigger 34 : When Case Status is updated, update It's number and Status in Account Description and Update the task status same as case status */

    public static void updateAccountAndTask(List<Case> caseList, Map<Id, Case> oldMap){
        
    }

    /* Trigger 35 : On case creation 
        1. Link case to primary contact (Checkbox field on Contact) of an account
        2. Create an event on same primary contact with same subject as Case.
    */
    public static void linkCaseToPrimaryContactAndCreateEvent(Map<Id, Case> newMap){
        
    } 

    /* Update account Site field with the latest inserted case number */
    public static void updateCaseNumber(List<Case> caseList){
    
    }
    
    /* When Case status changed to escalated, create a follow up taks on the related contact with same account to which case is associated*/
    public static void createTask(List<Case> caseList){
        if(caseList.size() > 0){
            Set<Id> accIdSet = new Set<Id>();
            for(Case c : caseList){
                if(c.Status == 'Escalated' && c.AccountId != NULL){
                    accIdSet.add(c.AccountId);
                }
            }
            
            if(accIdSet.size() > 0){
                List<Contact> conList = [SELECT Id FROM Contact WHERE AccountId IN : accIdset];
                List<Task> taskList = new List<Task>();
                if(conList.size() > 0){
                    for(Contact con : conList){
                        Task t = new Task();
                        t.WhoId = con.Id;
                        t.Description = 'Case is Escalated';
                        t.Priority = 'High';
                        taskList.add(t);
                    }
                }
                if(taskList.size() > 0){
                    insert taskList;
                }
            }
        }
    }
}