global class DailyLeadProcessor implements Schedulable {

    global void execute (schedulableContext cxt){
        List<lead> leadsToUpdate = new List<lead>();
        List<lead> leadList = [SELECT id FROM Lead WHERE leadSource = NULL LIMIT 200];
        for(lead l : leadList){
            l.leadSource = 'Dreamforce';
            leadsToUpdate.add(l);
        }
        update leadsToUpdate;
    }
}