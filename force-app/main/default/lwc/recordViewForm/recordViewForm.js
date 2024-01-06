import { LightningElement, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

import Account_Obj from '@salesforce/schema/Account';


export default class RecordViewForm extends NavigationMixin (LightningElement) {
    objectName = Account_Obj;
    @api recordId;

    clickHandler(){
        // Navigate to the Contact object's Recent list view.
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'objectName',
                actionName: 'list'
            },
            state: {
                
                filterName: 'Recent' 
            }
        });
    }
}