trigger UserTrigger on User (before insert, before update, after update) {
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            //UserHandler.assignUser(Trigger.new, NULL);
        }
        if(Trigger.isUpdate){
            //UserHandler.assignUser(Trigger.new, Trigger.OldMap);
        }
    }
    
    if(Trigger.isAfter){
        if(Trigger.isUpdate){
            UserHandler.assingOpenOppToManager(Trigger.New);
        }
    }
}