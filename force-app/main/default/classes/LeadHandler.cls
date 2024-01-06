public with sharing class LeadHandler {
    /* Trigger 32 : 
    * When lead is converted : 
        1. update Active picklist field to 'Yes' on Account : ConvertedAccountId
        2. Mark LeadContact checkbox checked on Contact : ConvertedContactId
        3. Updat Lead Name in the description on Opportunity : ConvertedOpportunityId
    */
    public static void onLeadConversion(List<Lead> leadlist) {
        
    }
}