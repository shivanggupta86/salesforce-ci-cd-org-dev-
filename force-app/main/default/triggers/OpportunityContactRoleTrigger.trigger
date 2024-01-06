trigger OpportunityContactRoleTrigger on OpportunityContactRole (before insert) {
    if(Trigger.isBefore && Trigger.isInsert){
        OpportunityContactRoleHandler.showErrorOnInsertionOfContactRole(Trigger.new);
    }
}