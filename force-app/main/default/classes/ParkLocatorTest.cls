@isTest
private class ParkLocatorTest {
    @isTest static void testCallout() {              
        // This causes a fake response to be generated
        Test.setMock(WebServiceMock.class, new ParkServiceMock());
        // Call the method that invokes a callout
        string country = 'United States';
        List<String> result = parkLocator.country(country);
        List<string> parks = new List<string>();
        parks.add('Yellowstone');
        parks.add('Another Park');
        parks.add('Yosemite');
        // Verify that a fake result is returned
        System.assertEquals(parks, result); 
    }
}