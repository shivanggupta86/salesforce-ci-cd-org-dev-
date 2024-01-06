public with sharing class FilePreviewAndDownloadHandler {
    
    @AuraEnabled (cacheable = true)
    public static List<ContentVersion> fileHandler(String recordId){
        List<ContentVersion> result = new List<ContentVersion>();

        if(String.isNotBlank(recordId)){
            List<ContentDocumentLink> cdLinkList = [SELECT Id, ContentDocumentId FROM ContentDocumentLink WHERE LinkedEntityId =: recordId];
            
            Set<Id> contentDocumentIdList = new Set<Id>();
            if(cdLinkList.size() > 0){
                for(ContentDocumentLink cdLink : cdLinkList){
                    contentDocumentIdList.add(cdLink.ContentDocumentId);
                }
                
                if(contentDocumentIdList.size () > 0){
                    List<ContentVersion> cvList = [SELECT ContentDocumentId, Title FROM ContentVersion WHERE ContentDocumentId IN : contentDocumentIdList];
                    if(cvList.size() > 0){
                        result = cvList;
                    }else{
                        result = null;
                    }
                }
            }
        }
        return result;
    }

    @AuraEnabled
    public static String deleteFiles(String contentDocumentId){
        String deleteMessage = '';
        if(String.isNotBlank(contentDocumentId)){
            List<ContentDocument> cdList = [SELECT Id FROM ContentDocument WHERE Id =: contentDocumentId];
            try{
                if(cdList.size() > 0){
                    delete cdList;
                    deleteMessage = 'File is deleted';
                }
            }catch(DMLException e){
                System.debug(e);
                deleteMessage = e.getMessage();
            }
        }
        return deleteMessage;
    }
}