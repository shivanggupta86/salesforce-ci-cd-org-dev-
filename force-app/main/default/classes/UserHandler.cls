public class UserHandler {
	/* When a user is created and Assign as Manager checkbox is checked, assign that as a manager if other users are associated to that team. if users are not
		not present in the team show error as 'Users do not exist in this team so you cannot assign this user as manager of the team.
		1. Finance Team
		2. IT Team
		3. Sales Team
	*/
    public static void assignUser(List<User> userList, Map<Id, User> oldMap){
        
    }
    
    /* Trigger 40 : When a user gets deactivated assign all the open opportunities to the manager. */
    public static void assingOpenOppToManager(List<User> userList){
        if(userList.size() > 0){
            Map<Id, Id> userManagerMap = new Map<Id, Id>();
            for(User u : userList){
                if(u.isActive == false){
                    userManagerMap.put(u.Id, u.ManagerId);
                }
            }
            if(userManagerMap.size() > 0){
                assignOpp(userManagerMap);
                               
            }
        }
    }
    
    @future
    private static void assignOpp(Map<Id, Id> userManagerMap){
        Map<Id, Opportunity> oppMap = new Map<Id, Opportunity>([SELECT Id, OwnerId FROM Opportunity WHERE OwnerId IN : userManagerMap.keySet() AND isClosed = False]);
        if(oppMap.size() > 0){
            for(Opportunity opp : oppMap.values()){
                if(userManagerMap.containsKey(opp.OwnerId)){
                    opp.OwnerId = userManagerMap.get(opp.OwnerId);
                }
            }
        }
        
        if(oppMap.size() > 0){
            update oppMap.values();
        } 
    }
}