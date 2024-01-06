public class AddPrimaryContact implements Queueable {
    
    private contact con;
    private string state;
    public AddPrimaryContact(Contact con, String state){
        this.con = con;
        this.state = state;
    }
    public void execute(QueueableContext context){
        List<Account> accounts = [SELECT id, Name, (SELECT FirstName, LastName, Id From Contacts) FROM Account
                                 WHERE BillingState =:State LIMIT 200];
        List<Contact> PrimaryContact = new List<Contact>();
        for(Account acc : accounts){
            Contact c = con.clone();
            c.AccountId = acc.id;
            PrimaryContact.add(c);
        }
        if(PrimaryContact.size()>0){
           insert PrimaryContact; 
        }
        
    }
    
}