public class RandomContactFactory {

    public static List <Contact> generateRandomContacts(Integer numOfContacts, String LastName){
        List<Contact> conList = new List<Contact>();
        for(Integer i =0; i<numOfContacts; i++){
            contact c = new contact();
            c.firstName = 'Test'+i;
            lastName = lastName;
            conlist.add(c);
        }
        return conList;
    } 
}