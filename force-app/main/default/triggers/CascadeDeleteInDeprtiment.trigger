trigger CascadeDeleteInDeprtiment on Department__c (before delete) {
    List<id> departmentList = new List<id>();
    for(Department__c d : Trigger.old)
    {
        departmentList.add(d.id);
    }
    List<Consultant__c> conlist = new list<Consultant__c>();
    conlist = [SELECT Id, Name, Department__c FROM Consultant__c where Department__c IN : departmentList];
    delete conlist;
}