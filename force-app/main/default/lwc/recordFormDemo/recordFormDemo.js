import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent'
import { NavigationMixin } from 'lightning/navigation'

import Account_Object from "@salesforce/schema/Account"
import Name from "@salesforce/schema/Account.Name"
import AnnualRevenue from "@salesforce/schema/Account.AnnualRevenue"
import Rating from "@salesforce/schema/Account.Rating"
import Industry from "@salesforce/schema/Account.Industry"
export default class RecordFormDemo extends NavigationMixin(LightningElement) {

    @api recordId;
    objectName = Account_Object;
    fieldSet = [Name, AnnualRevenue, Rating, Industry];

    successHandler(event) {
        console.log('Id :   ' + event.detail.id);
        this.recordId = event.detail.id;
        const toastEvent = new ShowToastEvent({
            title: 'Title',
            message: 'Record is created : ' + event.detail.id,
            variant: 'success'
        })
        this.dispatchEvent(toastEvent);

        //Navigating to Record Page
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId : this.recordId,
                objectApiName : this.objectName,
                actionName : 'view'
            }
        })
        

    }
}