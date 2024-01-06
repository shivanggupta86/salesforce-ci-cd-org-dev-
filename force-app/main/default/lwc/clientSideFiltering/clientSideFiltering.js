import { LightningElement,wire } from 'lwc';
import getContacts from '@salesforce/apex/ClientSideFilteringHandler.getContacts';
export default class ClientSideFiltering extends LightningElement {

    headings = ['Id', 'Name', 'Title', 'Email'];
    totalContacts;
    @wire(getContacts)
    fetchContacts({data, error}){
        if(data){
            this.totalContacts = data;
            console.log(this.totalContacts);
        }
        if(error){
            console.log(error.body.message);
        }
    }
}