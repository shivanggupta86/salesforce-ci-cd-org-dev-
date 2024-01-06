import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import Account_object from '@salesforce/schema/Account';
export default class CustomValidationOnSalesforceRecords extends LightningElement {
     /**************************************** Custom Validation for Salesforce Records ********************************/

     objectName = Account_object;

     saveHandler(event) {
         let comp1 = this.template.querySelector('.Name');
         console.log(comp1.value);
         let comp2 = this.template.querySelector(".AnnualRevenue");
         let value2 = comp2.value;
 
         if (comp1.value.length < 5) {
             comp1.setCustomValidity('Name must be greater than 5 letters');
         }
 
         if (value2 == "") {
             comp2.setCustomValidity("Value cannot be empty");
         }
         else if (isNaN(value2)) {
             comp2.setCustomValidity("Value must be a number");
         }
         else if (value2 < 1000) {
             comp2.setCustomValidity("Value must be greater than 1000");
         }
         else {
             comp1.setCustomValidity("");
             comp2.setCustomValidity("");
             const fields = event.detail.fields;
             fields.Name = comp1.value;
             fields.AnnualRevenue = comp2.value;
             this.template.querySelector('lightning-record-edit-form').submit(fields);
         }
         comp1.reportValidity();
         comp2.reportValidity();
     }
 
     successHandler(event) {
         const successMessage = new ShowToastEvent({
             title: 'Record is created',
             message: 'Record id ::: ' + event.detail.id,
             variant: 'success'
         });
         this.dispatchEvent(successMessage);
     }
     errorHandler(event) {
         const errorMessage = new ShowToastEvent({
             title: 'Error Occured',
             message: event.detail.messaage,
             variant: 'error'
         });
         this.dispatchEvent(errorMessage);
 
     }
}