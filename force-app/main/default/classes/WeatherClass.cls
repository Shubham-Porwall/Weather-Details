public with sharing class WeatherClass {
@AuraEnabled(cacheable=true)
    public static WeatherDetailsWrapeer getWaetherDetails(String cityName){
        // END POINT
        String apiKey = 'f7d6a8dbeb855eae41be1ecd0e1a7e56';
        String endPoint = 'https://api.openweathermap.org/data/2.5/weather';
        endPoint += '?q=' + cityName;
        endPoint += '&units=metric';
        endPoint += '&APPID=' + apiKey;
        System.debug('URL = ' + endPoint);

        // HTTP callout  to weather API
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endPoint);
        req.setMethod('GET');
        HttpResponse response = http.send(req);
        System.debug('resposne = ' + response + 'body' + JSON.deserializeUntyped(response.getBody()));

        // RETURN WEATHER WAPPER DEATILS
        WeatherDetailsWrapeer wd = new WeatherDetailsWrapeer();
        if(response.getStatusCode() == 200){
            Map<String, Object> result = (Map<String,Object>)JSON.deserializeUntyped(response.getBody());
            wd.city = String.valueOf(result.get('name'));
            Map<String,Object> main = (Map<String,Object>)(result.get('main'));
            wd.humadity = String.valueOf(main.get('humidity'));
            wd.temp = String.valueOf(main.get('temp'));
            wd.pressure = String.valueOf(main.get('pressure'));
            wd.tempmin = String.valueOf(main.get('temp_min'));
            wd.tempmax = String.valueOf(main.get('temp_max'));
        } 
        System.debug('Fianl Result = ' + wd);
        return wd;
    }

    public class WeatherDetailsWrapeer{
        @auraEnabled public String city {get; set;}
        @auraEnabled public String temp {get; set;}
        @auraEnabled public String pressure {get; set;}
        @auraEnabled public String humadity {get; set;}
        @auraEnabled public String tempmin {get; set;}
        @auraEnabled public String tempmax {get; set;}
    }
}