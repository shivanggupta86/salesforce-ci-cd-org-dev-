public class OpportunityLineItemHandler {

    /*** 
		When a product(OppLine) is inserted/updated/deleted/undeleted update total number of product associated with all it's related 
		opportunities in a field AccountNumber present on Account.
	***/
    
    public static void updateTotalProductsFieldInAccount(List<OpportunityLineItem> ProductsList){
        
    }
    
    
    
    /* 
		On insertion of an OppLineItem, create an asset and that asset should should be associate with the Parent account of Opportunity of OppLineItem 
		Account(p) ---> Asset(c)
		|
		Opportunity
		|
		OpportunityLineItem
	*/
    
    public static void createAssetOnCreation(List<OpportunityLineItem> oppLineItemList){
        
        
    }
    
    
    /* 
		What is OppLineItem? It is a Product when it is added to the Opportunity, it becomes OppLineItem.
		Scenario : Prevention the insertion of OpplineItem if it's Family picklist field matches with ProductFamily__c picklist field present on Opportunity.
	*/
    
    public static void preventInsertionOfOppLineItems(List<OpportunityLineItem> lineItemList){
        
    }

    /* Count OpportunityLineItem whose Sales Price is greater than $50,000 associated with Opportunity display that count on Account's Custom Field */
    public static void countOppLineItem(List<OpportunityLineItem> oppLineItemList, Map<Id, OpportunityLineItem> oldMap){
        
    }

    /* Update Account's description with Opportunity Line item description which is associated with Opportunity */
    public static void updateAccountDescription(List<OpportunityLineItem> oppLineItemList){
        
    }
}