public class AccountProcessor {
    
    @future
    public static void countContacts(List<id> accId){
        List<AggregateResult> Result = [SELECT Count(id) TotalCount FROM Contact WHERE AccountId =: accId];
        List<Account> accList = [SELECT id FROM Account WHERE id=:accId];
        for(Account acc : accList){
            for(AggregateResult agg : Result){
                acc.Number_Of_Contacts__c = Integer.valueOf(agg.get('TotalCount'));
                System.debug(acc.Number_Of_Contacts__c);
            }
        }
        
    } 
}