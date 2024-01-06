import { LightningElement } from 'lwc';
import Account_Object from '@salesforce/schema/Account';
export default class CustomValidation2 extends LightningElement {
    objectName = Account_Object;
    inputValue = '';
    inputValue2 = '';
    handleInput(event) {
        if (event.target.title == "name") {
            this.inputValue = event.target.value;
        }
        else if (event.target.title == "annualRevenue") {
            this.inputValue2 = event.target.value;
        }
    }

    submitHandler(event) {
        const inputCmp = this.template.querySelectorAll('lightning-input');
        Array.from(inputCmp).forEach(item => {
            if (item.title == "name") {
                console.log('inputCmp.title == "name"', item.title == "name")
                const value1 = item.value;
                console.log('value1 ::: ', value1);
                if (!value1.includes('Australia')) {
                    item.setCustomValidity("Name must contain 'Australia'");
                }
                else {
                    item.setCustomValidity('');
                    const fields = event.detail.fields;
                    fields.Name = item.value;
                    console.log('fields.Name ::: ', fields.Name)
                    this.template.querySelector('lightning-record-edit-form').submit(fields);
                }
                item.reportValidity();
                
            }
            else if (item.title == "annualRevenue") {
                console.log('inputCmp.title == "annualRevenue"', item.title == "annualRevenue")
                const value2 = item.value;
                console.log('value2 :::', value2)
                if (isNaN(value2)) {
                    item.setCustomValidity("Value must be a number");
                }
                else {
                    item.setCustomValidity('');
                    const fields = event.detail.fields;
                    fields.AnnualRevenue = item.value;
                    console.log('fields.AnnualRevenue ::: ', fields.AnnualRevenue)
                    this.template.querySelector('lightning-record-edit-form').submit(fields);
                    console.log(event.detail.message)
                }
                item.reportValidity(); 
            }     
        })
    }
}