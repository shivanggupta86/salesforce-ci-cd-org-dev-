import { LightningElement, wire } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
export default class DownloadAttachments extends LightningElement {

    @wire(CurrentPageReference)
    getPageReferenceParameters(currentPageReference) {
       if (currentPageReference) {
          console.log('currentPageReference is : ',currentPageReference);
        //   this.recordId = currentPageReference.attributes.recordId || null;
        //   let attributes = currentPageReference.attributes;
        //   let states = currentPageReference.state;
        //   let type = currentPageReference.type;
       }
    }
    
}