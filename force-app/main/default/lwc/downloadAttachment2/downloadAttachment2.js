import { LightningElement, api } from 'lwc';
import getContentDocumentIds from '@salesforce/apex/DownloadAttachment2Handler.getContentDocumentIds';
export default class DownloadAttachment2 extends LightningElement {

    @api recordId
    @api invoke(){
       getContentDocumentIds({recordId : this.recordId})
       .then( result => {
        console.log('ContentDocumentIds : ',result);
        this.filesData = result.map( item => (
            {...item, url : `/sfc/servlet.shepherd/document/download/${item}`}
        ))
        console.log('filesData : ',this.filesData);
       }).catch( error => {
        console.log(error);
       })
    }
}