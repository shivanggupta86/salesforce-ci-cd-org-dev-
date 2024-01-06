import { LightningElement, api, wire } from 'lwc';
import fileHandler from '@salesforce/apex/FilePreviewAndDownloadHandler.fileHandler';
import deleteFiles from '@salesforce/apex/FilePreviewAndDownloadHandler.deleteFiles';
import { NavigationMixin } from "lightning/navigation";
import FileMessageChannel from "@salesforce/messageChannel/FileMessageChannel__c";
import {MessageContext, subscribe, APPLICATION_SCOPE} from 'lightning/messageService';
import { refreshApex } from '@salesforce/apex';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class FilePreviewAndDownload extends NavigationMixin(LightningElement) {
    @api recordId
    filesData;
    dataToRefresh; //Used to refresh data after upload the file from fileUploaderDemo component
    @wire(MessageContext)
    context;

    @wire(fileHandler, { recordId: '$recordId' })
    filefunction(result){
        if(result.data){
            
            this.filesData = result.data.map(item => (
                { ...item, url: `/sfc/servlet.shepherd/document/download/${item.ContentDocumentId}` }
            ))
            console.log('modified => ', this.filesData);
            this.dataToRefresh = result; //To refresh data in wire method you have to store the complete result recieved from server side
        }
        if (result.error) {
            console.log(error);
        }
        
    }
    /* filefunction({ data, error }) {
        if (data) {
            console.log(data);
            this.dataReceived = data;
            this.filesData = data.map(item => (
                { ...item, url: `/sfc/servlet.shepherd/document/download/${item.ContentDocumentId}` }
            ))
            console.log('modified => ', this.filesData);
        }
        if (error) {
            console.log(error);
        }
    } */

    connectedCallback(){
        subscribe(this.context, FileMessageChannel, (message)=>{this.handleMessage(message)}, {scope : APPLICATION_SCOPE})
        console.log('Channel Subscribed')
    }

    handleMessage(message){
        console.log('received data : ', message.refreshData);
        if(message.refreshData == 'Yes'){
            refreshApex(this.dataToRefresh); //Refreshing the complete result received from server side controller
        }
        
    }


    previewHandler(event) {
        console.log(event.target.dataset.id)
        this[NavigationMixin.Navigate]({
            type: "standard__namedPage",
            attributes: {
                pageName: "filePreview",
            },
            state: {
                selectedRecordId: event.target.dataset.id,
            },
        });
    }

    deleteHandler(event){
        deleteFiles({contentDocumentId : event.target.dataset.id})
        .then( result => {
            console.log(result);
            refreshApex(this.dataToRefresh);
            this.dispatchEvent(new ShowToastEvent({
                title: "Success",
                message: `File is deleted !!!`,
                variant: "success"
            }));
        }).catch( error => {
            console.log(error.body.message);
        })
    }

}