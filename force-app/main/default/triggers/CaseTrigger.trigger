trigger CaseTrigger on Case (after insert, after update, after delete, after undelete) {
    if(Trigger.isAfter && Trigger.isUpdate){
        CaseHandler.createTask(Trigger.new);
    }
    if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUndelete)){
        CaseHandler.createTask(Trigger.new);
    }
    if(Trigger.isAfter && Trigger.isdelete){
        
    }
}