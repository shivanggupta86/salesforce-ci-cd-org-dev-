//Show error if lead status is getting changed to Closed-converted or Closed-NotConverted if status is changed 
//from working-contacted
trigger ShowErrorOnLead on Lead (before update) {

    for(Lead l : Trigger.new){
        if(l.Status == 'Closed - Converted' || l.Status == 'Closed - Not Converted' && Trigger.oldMap.get(l.id).status == 'Working - Contacted'){
            l.addError('You cannot change the status');
        }
    }
}