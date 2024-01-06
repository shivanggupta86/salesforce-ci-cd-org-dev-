import { LightningElement, api } from 'lwc';

export default class PaginationUtilityComponent extends LightningElement {
    recordsReceived;
    visibleRecords
    @api totalItems
    connectedCallback(){
        console.log(this.totalItems);
    }
    /* get totalItems(){
        return this.visibleRecords;
    }
    set totalItems(value){
        
        this.recordsReceived = value;
        console.log(value);
    } */
}