import { LightningElement } from 'lwc';
import getRelatedContacts from '@salesforce/apex/RecordPickerDemoHandler.getRelatedContacts';
const columns =[
    {fieldName:'Name', label:'Contact Name', type:'text'},
    {fieldName:'Phone', label:'Phone', type:'phone'},
    {fieldName:'Email', label:'Email', type:'email'},
]
export default class RecordPickerDemo extends LightningElement {
    accountId;
    columns = columns;
    data;
    handleChange(event){
        this.accountId = event.detail.recordId;
        console.log(event.detail.recordId)
        this.searchRelatedContacts(this.accountId);
    }

    searchRelatedContacts(accountId){
        getRelatedContacts({recordId : accountId})
        .then( result => {
            this.data = result;
        }).catch( error => {
            console.log(error.body.message);
        })
    }
    
}