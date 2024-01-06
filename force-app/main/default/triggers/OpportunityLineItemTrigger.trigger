trigger OpportunityLineItemTrigger on OpportunityLineItem (after insert, after update, after delete, after undelete, before insert) {
    if(Trigger.isAfter){
        if(Trigger.isInsert || Trigger.isUndelete){
            //OpportunityLineItemHandler.updateTotalProductsFieldInAccount(Trigger.new);
            // OpportunityLineItemHandler.createAssetOnCreation(Trigger.new);
            // OpportunityLineItemHandler.countOppLineItem(Trigger.new, NULL);
            OpportunityLineItemHandler.updateAccountDescription(Trigger.new);
            
        }
        if(Trigger.isUpdate){
            //OpportunityLineItemHandler.updateTotalProductsFieldInAccount(Trigger.old);
            // OpportunityLineItemHandler.countOppLineItem(Trigger.New, Trigger.OldMap);
            OpportunityLineItemHandler.updateAccountDescription(Trigger.New);
        }
        if(Trigger.isDelete){
            //OpportunityLineItemHandler.updateTotalProductsFieldInAccount(Trigger.old);
            // OpportunityLineItemHandler.countOppLineItem(Trigger.old, NULL);
        }
    }

    if(Trigger.isBefore && Trigger.isInsert){
        // OpportunityLineItemHandler.preventInsertionOfOppLineItems(Trigger.new);
    }
}