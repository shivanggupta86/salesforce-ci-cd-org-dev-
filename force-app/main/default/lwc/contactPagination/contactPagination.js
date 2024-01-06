import { LightningElement,wire } from 'lwc';
import getContacts from '@salesforce/apex/ContactPaginationHandler.getContacts';
export default class ContactPagination extends LightningElement {

    totalContacts;
    @wire(getContacts, {})
    fetchContacts({data, error}){
        if(data){
            console.log(data);
            this.totalContacts = data;
        }
        if(error){
            console.log(error.body.message);
        }
    }
}