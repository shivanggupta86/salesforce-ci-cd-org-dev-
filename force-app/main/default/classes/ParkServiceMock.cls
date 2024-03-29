@isTest
global class ParkServiceMock implements WebServiceMock {
    global void doInvoke(
        Object stub,
        Object request,
        Map<String, Object> response,
        String endpoint,
        String soapAction,
        String requestName,
        String responseNS,
        String responseName,
        String responseType) {
            // start - specify the response you want to send
            List<string> parks = new List<String>();
            parks.add('Yellowstone');
            parks.add('Another Park');
            parks.add('Yosemite');
            ParkService.byCountryResponse response_x = 
                new ParkService.byCountryResponse();
            response_x.return_x = parks;
            // end
            response.put('response_x', response_x); 
        }
}