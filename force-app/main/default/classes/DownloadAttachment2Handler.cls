public with sharing class DownloadAttachment2Handler {
    @AuraEnabled 
    public static List<Id> getContentDocumentIds(String recordId){
        List<Id> cdIds = new List<Id>();
        if(recordId.startsWith('500')){
            List<ContentDocumentLink> cdLinkList = [SELECT ContentDocumentId FROM ContentDocumentLink where LinkedEntityId in ( SELECT Id FROM Case ) and LinkedEntity.Type='Case' ];

            
            for(ContentDocumentLink cdLink : cdLinkList){
                cdIds.add(cdLink.ContentDocumentId);
            }

            
        }
        return cdIds;
    }
}