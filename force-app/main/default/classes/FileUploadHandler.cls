public with sharing class FileUploadHandler {
    
    @AuraEnabled
    public static String uploadAttachments(String base64, String fileName, String recordId){
        ContentVersion cv = createCversion(base64, fileName);
        ContentDocumentLink cdLink = createClink (cv.Id, recordId);
        if(cv == null && cdLink == null){
            return null;
        }
        return cdLink.Id;
    }

    //Create a ContentVersion to save the uploaded document
    public static ContentVersion createCversion(String base64, String fileName){
        ContentVersion cv = new ContentVersion();
        cv.VersionData = EncodingUtil.base64Decode(base64);
        cv.Title = fileName;
        cv.pathOnClient = fileName;
        try{
            insert cv;
            return cv;
        }catch(DMLException e){
            System.debug(e);
            return null;
        }
    }


    //Create ContentDocumentLink to link the uploaded document with the associated Object (Account, Case etc.)
    public static ContentDocumentLink createClink(String contentVersionId, String recordId){
        ContentDocumentLink cdLink = new ContentDocumentLink();
        cdLink.ContentDocumentId = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =: contentVersionId].ContentDocumentId;
        cdLink.LinkedEntityId = recordId;
        cdLink.ShareType = 'V';
        try{
            insert cdLink;
            return cdLink;
        }catch(DMLException e){
            System.debug(e);
            return null;
        }
    }
}