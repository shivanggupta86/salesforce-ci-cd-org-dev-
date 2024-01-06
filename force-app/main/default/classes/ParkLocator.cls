public class ParkLocator {

    public static List<String> country (String country){
        parkservice.ParksImplPort parkservice = new parkservice.ParksImplPort();
        return parkservice.byCountry(country);
    }
}