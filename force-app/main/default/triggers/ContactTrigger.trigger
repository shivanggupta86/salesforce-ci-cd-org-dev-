trigger ContactTrigger on Contact (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    if(Trigger.isbefore && Trigger.isUpdate){
		
    }
    if(Trigger.isbefore && Trigger.isInsert ){
        /*contactHandler.preventDuplicationOfContact(Trigger.new, null);*/
    }
    if(Trigger.isbefore && Trigger.isdelete){
    }

    if(Trigger.isAfter){
        /*if(Trigger.isInsert || Trigger.isUndelete){
            contactHandler.rollUpSummary(Trigger.new, NULL);
        }
        if(Trigger.isdelete){
            contactHandler.rollUpSummary(Trigger.old, NULL);
        }
        if(Trigger.isUpdate){
            contactHandler.rollUpSummary(Trigger.new, Trigger.oldMap);
        }*/
    }
}