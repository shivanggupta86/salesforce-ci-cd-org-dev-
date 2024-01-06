public with sharing class newsAppHandler {
    
    @AuraEnabled(cacheable = true)
    public static String sendDataToClient(String keyword){
        String API_KEY = 'ad8498467a9f4f51b5fd603676563935';
        String strDate = String.valueOf(Date.today()-1);
        HTTP h = new HTTP();
        HTTPRequest request = new HTTPRequest();
        request.setEndPoint('https://newsapi.org/v2/top-headlines?country='+keyword+'&category=business&apiKey='+API_KEY);
        System.debug('https://newsapi.org/v2/top-headlines?country='+keyword+'&category=business&apiKey='+API_KEY);
        request.setMethod('GET');
        HTTPResponse response = h.send(request);
        System.debug(response.getBody());
        return response.getBody();
    }

    @AuraEnabled
    public static String saveNews(News__c article){
        String message = '';
        System.debug('Received Data from Client => '+article);
        if(article != NULL){
            try{
                String ArticleName = article.Name.mid(0, 80);
                List<News__c> existingArticles = [SELECT Id, Name FROM News__c WHERE Name =: ArticleName];
                if(existingArticles.size() > 0){  
                    throw new CustomException('This article already exists');
                }else{
                    News__c news = new News__c();
                    news.Name = ArticleName;
                    news.newsURL__c = article.newsURL__c;
                    news.Source__c = article.Source__c;
                
                    insert news ; 
                    message = 'Article Saved !!!';
                }
            }
            catch(Exception e){
                throw new AuraHandledException(e.getMessage());
            }   
        }
        return message;
    }

    @AuraEnabled
    public static List<News__c> getNews(){
        return [SELECT Id, Name, newsURL__c, Source__c FROM News__c];
    }

    @AuraEnabled
    public static String deleteBookmark(List<Id> articleIdList){
        String msg = '';
        List<News__c> newsList = [SELECT Id FROM News__c WHERE Id IN : articleIdList];
        if(newsList.size() > 0){
            delete newsList;
            msg = 'Bookmark removed';
        }
        return msg;
    }

    @AuraEnabled
    public static String deleteAll(){
        String msg = '';
        List<News__c> newsList = [SELECT Id FROM News__c];
        if(newsList.size() > 0){
            delete newsList;
            msg = 'All Successfully Deleted';
        }
        return msg;
    }
}