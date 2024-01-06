import { LightningElement, api } from 'lwc';

export default class ChildCmp extends LightningElement {
    
    /* userData;
    @api 
    get userdetail(){
        return this.userData;
    }

    set userdetail(data){
        //If you want to add a new property or modify the existing property, you must create a shallow copy of the object
        this.userData = {...data, "Company" : "Wissen Infotech"};
    } */
    handleSlotChange(){
        const footerelem = this.template.querySelector('.slds-card__footer');
        footerelem.classList.remove('slds-hide');
    }
}