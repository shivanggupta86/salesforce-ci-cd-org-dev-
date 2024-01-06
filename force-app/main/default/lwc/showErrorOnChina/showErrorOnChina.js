import { LightningElement } from 'lwc';
import Account_Object from '@salesforce/schema/Account';
import getCountryMethod from '@salesforce/apex/showErrorOnChinaHandler.getCountry'
export default class ShowErrorOnChina extends LightningElement {
    objectName = Account_Object;
    changeHandler(event) {
        console.log(event.target.value);
        let countryId = event.target.value;
        getCountryMethod({ countryId: countryId })
            .then(result => {
                console.log(result);
                let inputCmp = this.template.querySelector('lightning-input');
                console.log(inputCmp)
                if (result == true) {
                    inputCmp.setCustomValidity(`Don't enter any sensitive information`);
                }
                inputCmp.reportValidity();
            }).catch(error => {
                let inputCmp = this.template.querySelector('lightning-input');
                if (error.status == 500) {
                    inputCmp.setCustomValidity("");
                }
                inputCmp.reportValidity();
            })
    }

}