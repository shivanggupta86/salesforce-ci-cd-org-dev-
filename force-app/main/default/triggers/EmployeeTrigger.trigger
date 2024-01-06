trigger EmployeeTrigger on Employee__c (after insert, after update) {
    if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUndelete))
    	EmployeeHandler.updateTechFirmSalary(Trigger.new, NULL);
    
    if(Trigger.isAfter && Trigger.isUpdate)
        EmployeeHandler.updateTechFirmSalary(Trigger.new, Trigger.oldMap);
        
    if(Trigger.isAfter && Trigger.isDelete)
        EmployeeHandler.updateTechFirmSalary(Trigger.old, NULL);
}