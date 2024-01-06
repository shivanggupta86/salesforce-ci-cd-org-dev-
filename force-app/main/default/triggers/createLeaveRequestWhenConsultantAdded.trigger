trigger createLeaveRequestWhenConsultantAdded on Consultant__c (after insert) {
List<Leave_Request__c>lrList = new List<Leave_Request__c>();
    
    for(Consultant__c c : Trigger.new)
    {
        if(c.type__c == 'Employee')
        {
           Leave_Request__c lr =new Leave_Request__c();
           lr.name = 'HOLI leave';
           lr.Consultant__c = c.id; 
           lrList.add(lr);
        }
        
    }
    insert lrList;  
}