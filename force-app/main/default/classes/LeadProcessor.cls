public class LeadProcessor implements Database.Batchable<sObject> {

    public Database.QueryLocator start(Database.BatchableContext bc) {
    	return Database.getQueryLocator('SELECT id FROM Lead');
    }
    public void execute(Database.BatchableContext bc, List<Lead> leadList){
        for(Lead l : leadList){
            l.leadSource = 'Dreamforce';
        }
    }
    public void finish(Database.BatchableContext bc){
        
    }
}