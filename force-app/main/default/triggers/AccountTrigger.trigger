trigger AccountTrigger on Account (after update, before update, after insert) {

    if(Trigger.isAfter && Trigger.isUpdate){
        //AccountHandler.closeOpportunity(Trigger.new, Trigger.oldMap);
        //AccountHandler.deleteOpportunities(Trigger.new, Trigger.oldMap);
    }

    if(Trigger.isBefore && Trigger.isUpdate){
        AccountHandler.updateParentAccountWithHighestOpportunity(Trigger.new);
        //AccountHandler.updateAccountNameWithThirdContactName(Trigger.new, Trigger.OldMap);
    }
    if(Trigger.isAfter && Trigger.isInsert){
        // AccountHandler.insertContactInClientContact(Trigger.new);
        //AccountHandler.closeOpportunity(Trigger.new, NULL);
    }
    
}