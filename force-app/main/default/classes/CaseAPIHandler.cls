public class CaseAPIHandler {

    public static List<Case> caseData(){
        List<Case> cases = [SELECT Subject, Status, Origin FROM Case WHERE AccountId = Null];
        return cases;
    }
    
    public static void SendDataToApi(){
        HTTPRequest request = new HTTPRequest();
        String endpoint = 'callOut:SFDC/services/apexrest/cases';
        request.setEndpoint(endPoint);
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setBody(JSON.serialize(caseData()));
        System.debug(JSON.serialize(request.getBody()));
        
        HTTP http = new HTTP();
		
        
        HTTPResponse response = http.send(request);
        System.debug('Status Code => '+response.getStatusCode()+'   Status => '+response.getStatus());
    }
}