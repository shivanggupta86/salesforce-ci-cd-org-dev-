trigger LeadTrigger on Lead (after insert, after update, after delete, after undelete) {

    if(Trigger.isAfter){
        if(Trigger.isUpdate){
            LeadHandler.onLeadConversion(Trigger.new);
        }
    }
}