trigger OpportunityTrigger on Opportunity (after update, after insert, after delete, after undelete) {
    if(Trigger.isAfter && Trigger.isUpdate){
        //OpportunityHandler.updateOrCreateTask(Trigger.new, Trigger.OldMap);
        //OpportunityHandler.updateAccountSiteOnAccount(Trigger.new, Trigger.OldMap);
        //OpportunityHandler.updateAccountStatus(Trigger.new, Trigger.OldMap);
        //OpportunityHandler.updateAccountRating(Trigger.new, Trigger.OldMap);
        //OpportunityHandler.insertOrDeleteContactRole(Trigger.new, Trigger.OldMap);
        //OpportunityHandler.updateOrCreateTask(Trigger.new, Trigger.OldMap);
    }
    if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUnDelete)){
        //OpportunityHandler.updateAccountSiteOnAccount(Trigger.new, null);
        //OpportunityHandler.updateOrCreateTask(Trigger.new, null);
        //OpportunityHandler.updateAccountStatus(Trigger.new, null);
        //OpportunityHandler.updateAccountRating(Trigger.new, null);
    }
    if(Trigger.isAfter && Trigger.isDelete){
        //OpportunityHandler.updateAccountSiteOnAccount(Trigger.Old, null);
        //OpportunityHandler.updateAccountStatus(Trigger.Old, null);
        //OpportunityHandler.updateAccountRating(Trigger.Old, null);
    }
}