import { LightningElement } from 'lwc';

export default class CustomEventParent extends LightningElement {
    isVisible = false;
    showModal(){
        console.log('showModal is called')
        this.isVisible = true;
    }
    closeHandler(){
        console.log('Parent closeHandler called');
        this.isVisible = false;
    }
}