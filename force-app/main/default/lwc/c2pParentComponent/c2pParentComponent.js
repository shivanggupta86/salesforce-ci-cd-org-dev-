import { LightningElement } from 'lwc';

export default class C2pParentComponent extends LightningElement {
    showModal = false
    clickHandler(){ 
        this.showModal = true
    }
    closeHandler(){ 
        this.showModal = false
    }
/* 
    isVisible = false;
    showModal(){
        console.log('showModal is called')
        this.isVisible = true;
    }
    closeHandler(){
        console.log('closeHandler called');
        this.isVisible = false;
    }
 */
}