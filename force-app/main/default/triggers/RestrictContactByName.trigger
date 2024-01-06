trigger RestrictContactByName on Contact (before insert, before update) {
    
    //check contacts prior to insert or update for invalid data
    For (Contact c : Trigger.New) {
        if(c.LastName == 'INVALIDNAME') {   //invalidname is invalid
            c.AddError('The Last Name is not allowed for DML');
        }

    }
}