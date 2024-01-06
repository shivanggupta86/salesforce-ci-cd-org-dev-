public with sharing class ZipFileCreationHandler {
    @AuraEnabled
    public static List<Id> getFiles(String recordId){
        List<Id> cdIds = new List<Id>();
        List<Id> contentVersionIds = new List<Id>();
        if(recordId.startsWith('500')){
            List<ContentDocumentLink> cdLinkList = [SELECT ContentDocumentId, LinkedEntityId FROM ContentDocumentLink where LinkedEntityId in ( SELECT Id FROM Case ) and LinkedEntity.Type='Case' ];

            
            for(ContentDocumentLink cdLink : cdLinkList){
                cdIds.add(cdLink.ContentDocumentId);
            }

            for(ContentVersion cv: [SELECT Id FROM ContentVersion 
                                    WHERE ContentDocumentId IN:cdIds 
                                    AND isLatest=true]){
                                        contentVersionIds.add(cv.Id);
                                    }
            return contentVersionIds;
            
        }else{
            return null;
        }
        
    }
}