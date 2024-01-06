import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
export default class CustomValidation extends LightningElement {
    objectName = ACCOUNT_OBJECT;
    inputValue = ''
    handleChange(event) {
        this.inputValue = event.target.value;
        console.log(this.inputValue);
    }
    submitHandler(event) {
        const inputCmp = this.template.querySelector('lightning-input');
        const value = inputCmp.value;

        if (!value.includes('India')) {
            console.log(!value.includes('India'));
            inputCmp.setCustomValidity('Name must contain India')
        } else {
            inputCmp.setCustomValidity("");
            const fields = event.detail.fields;
            console.log(JSON.stringify(fields));
            fields.Name = value;
            this.template.querySelector('lightning-record-edit-form').submit(fields);
        }
        inputCmp.reportValidity();
    }
    successHandler(event){
        /* const updatedRecord = event.detail.fields.Name.value;
        console.log('onsuccess: ', updatedRecord);
        const payload = event.detail;
        console.log(JSON.stringify(payload)); */
      const successMessage =  new ShowToastEvent({
            title : 'Success !!!',
            message : 'Record is created  ' +event.detail.id,
            variant : 'success'
        })
        this.dispatchEvent(successMessage);
    }
    errorHandler(event) {
       const errorMessage = new ShowToastEvent({
            title : 'Error !!!',
            message : event.detail.message,
            vairant : 'error'
        })
        this.dispatchEvent(errorMessage);
    }
}