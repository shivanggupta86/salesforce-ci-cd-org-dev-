import { LightningElement } from 'lwc';

export default class CustomValidation3 extends LightningElement {


    /****************************** Custom Validation by calling lightning-input with class name ****************************/

    /* clickHandler(){
        let comp1 = this.template.querySelector('.Name');
        let value1 = comp1.value;

        let comp2 = this.template.querySelector(".AnnualRevenue");
        let value2 = comp2.value;

        if(value1.length < 5){
            comp1.setCustomValidity('Name must be greater than 5 letters');
        }
        else{
            comp1.setCustomValidity("");
        }
        comp1.reportValidity();

        if(value2 == ""){
            comp2.setCustomValidity("Value cannot be empty");
        } 
        else if(isNaN(value2)){
            comp2.setCustomValidity("Value must be a number");
        }
        else if(value2 < 1000){
            comp2.setCustomValidity("Value must be greater than 1000");
        }       
        else{
            comp2.setCustomValidity("");
        }
        comp2.reportValidity();
    } */


    /**************************************** Custom Validation by iterating all lightning-input ********************************/

    clickHandler(){
        let comp = this.template.querySelectorAll('lightning-input');
        Array.from(comp).forEach(item => {
            if(item.title =="Name"){
                const value1 = item.value;
                if(value1.length < 5){
                    item.setCustomValidity('Name must be greater than 5 letters');
                }
                else{
                    item.setCustomValidity("");
                }
                item.reportValidity();
            }
            if(item.title == "AnnualRevenue"){
                const value2 = item.value;
                if(value2 == ""){
                    item.setCustomValidity("Value cannot be empty");
                } 
                else if(isNaN(value2)){
                    item.setCustomValidity("Value must be a number");
                }
                else if(value2 < 1000){
                    item.setCustomValidity("Value must be greater than 1000");
                }       
                else{
                    item.setCustomValidity("");
                }
                item.reportValidity();
            }

        });
    }

   
}