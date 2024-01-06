public class Email_Test2 {
    public static void Email_method(){
        messaging.SingleEmailMessage SingleMsg = new messaging.SingleEmailMessage();
        SingleMsg.toaddresses = new String[] {'pallavifalke.965@gmail.com'};
        SingleMsg.ccaddresses = new String[] {'testsalesforce1993@gmail.com'};
        singleMsg.setSubject('This message generated via apex');
        singleMsg.setPlainTextBody('Hi! This is Salesforce generated email');
        //singleMsg.setSenderDisplayName('Pallavi');
        List<messaging.SingleEmailMessage> EmailList = new List<messaging.SingleEmailMessage>();
        EmailList.add(singleMsg);
        messaging.sendEmail(EmailList);
    }
}