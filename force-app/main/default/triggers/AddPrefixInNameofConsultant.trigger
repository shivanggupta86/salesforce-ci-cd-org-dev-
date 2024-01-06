trigger AddPrefixInNameofConsultant on Consultant__c (before insert) {
    for(Consultant__c con : Trigger.new)
    {
        if(con.type__c == 'Employee')
        {
            con.Name =  con.Name + ' Gupta';
        }
    }
}