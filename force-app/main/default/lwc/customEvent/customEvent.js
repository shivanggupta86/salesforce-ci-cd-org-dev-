import { LightningElement } from 'lwc';

export default class CustomEvent extends LightningElement {
    closeHandler() {
        console.log('closeHandler called');
        const myEvent = new CustomEvent('close');
        this.dispatchEvent(myEvent);
    }
}