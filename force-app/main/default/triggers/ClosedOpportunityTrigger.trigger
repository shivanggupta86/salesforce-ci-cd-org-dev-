trigger ClosedOpportunityTrigger on Opportunity (after insert , after update) {
    
    List<Task> TaskList = new List<Task>();
    for(Opportunity opp : Trigger.new){
        if(opp.StageName == 'Closed Won'){
            TaskList.add(new Task(Subject = 'Follow Up Test Task', WhatId = opp.id));
        }
    }
    insert TaskList;
}