import { LightningElement } from 'lwc';
import getAccountsAndContacts from  '@salesforce/apex/AccountAndContactWrapper.getAccountsAndContacts';
export default class AccountDetailsCmp extends LightningElement {
    accName = '';
    timer;
    data;
    changeHandler(event){
        window.clearTimeout(this.timer);
        this.accName = event.target.value;
        this.timer = setTimeout(() => {
            this.callApex()
        }, 1500);
        
    }

    callApex(){
        getAccountsAndContacts({accName : this.accName})
        .then(result =>{
            console.log(result);
            this.data = result;
        }).catch(error =>{
            console.log(error);
        })
    }
}