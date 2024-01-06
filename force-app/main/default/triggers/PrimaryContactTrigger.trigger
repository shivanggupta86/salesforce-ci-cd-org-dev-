//Show Error if an Account has more than one Primary Contact

/* Not working when :
    When you try to update two records in the same account in Bulk, it will through the error. Let say you have two Contacts, 
    Contact 1 - Account A - isPrimary (false) - previous value (true)
    Contact 2 - Account A - isPrimary (true) - previous value (false)

    if you try to update them together trigger will throw the error, however if you observe there would be only one Primay contact left at the 
    end of the transaction, in that case it should not throw error but it would throw.
 */  
trigger PrimaryContactTrigger on Contact (before insert, before update) {

    Set<Id> accIdSet = new Set<Id>();
    Map<Id, Integer> conMap = new Map<Id, Integer>();
    if(Trigger.isBefore && Trigger.isUpdate){
        for(Contact con : Trigger.new){
            if(con.AccountId != Trigger.oldMap.get(con.Id).AccountId){
                accIdSet.add(con.AccountId);
                accIdSet.add(Trigger.oldMap.get(con.Id).AccountId);
            }else{
                accIdSet.add(con.AccountId);
            }
        }
    }
    
    if(Trigger.isBefore && Trigger.isInsert){
        for(Contact con : Trigger.new){
            accIdSet.add(con.AccountId);
        }
    }
    
    if(!accIdSet.isEmpty()){
        List<Contact> conList = [SELECT Id, Primary__c, AccountId FROM Contact WHERE AccountId IN : accIdSet AND Primary__c = True];
        
        if(!conList.isEmpty()){
            for(Contact con : conList){
                conMap.put(con.AccountId, conList.size());
            }
            
            for(Contact con : Trigger.New){
                if(conMap.containsKey(con.AccountId) && conMap.get(con.AccountId) > 0 && 
                   !Trigger.OldMap.get(con.Id).Primary__c && Trigger.OldMap != NULL && con.Primary__c == true){
                       con.addError('Only one primary contact is allowed per account');
                   }
            }
        }
    }

}