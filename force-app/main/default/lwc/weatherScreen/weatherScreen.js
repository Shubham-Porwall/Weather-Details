import { LightningElement, wire } from 'lwc';
import getWaetherDetails from '@salesforce/apex/WeatherClass.getWaetherDetails';

export default class WeatherScreen extends LightningElement {
    inputcity = '';
    showDetails = false;
    WaetherDetails = {};
    
    handleInputChnage(event){
        this.inputcity = event.target.value;
    }

    // @wire(getWaetherDetails, {cityName: this.inputcity})
    
    handleClick(){
        getWaetherDetails({cityName: this.inputcity})
        .then((result) => {
            this.WaetherDetails = result;
            this.showDetails = true;
        })
        .catch((error) => {
            this.showDetails = false;
            console.log("some eroor while fetch data");
        });
        console.log("result" + JSON.stringify(this.WaetherDetails));
    }
}