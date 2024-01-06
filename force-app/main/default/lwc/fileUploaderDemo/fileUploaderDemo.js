import { LightningElement, api, wire } from 'lwc';
import uploadAttachments from '@salesforce/apex/FileUploadHandler.uploadAttachments';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import FileMessageChannel from "@salesforce/messageChannel/FileMessageChannel__c";
import {publish, MessageContext} from 'lightning/messageService';
export default class FileUploaderDemo extends LightningElement {
    @wire(MessageContext)
    context; 

    @api recordId //recordId of the current record where the file is being uploaded
    fileData;
    onload = false;
    uploadHandler(event){
        const file = event.target.files[0]; //Accepts file in binary format
        console.log(file);
        
        const reader = new FileReader(); //FileReader is a constructor used to read file data
        reader.readAsDataURL(file);  //Reading the file and Converting it to base64 format

        /* 
            After the reading is over, the result can be accessed in this way:

            1. The result is reader.result.
            2. The error is reader.error.
        */
        
        //Fires when a reading is completed successfully and it runs asynchronously
        reader.onload =()=> {
            const base64Data = reader.result.split(',')[1] //contains base64 formatted data of file.
            this.fileData = {
                'base64' : base64Data, 
                'fileName' : file.name,
                'recordId' : this.recordId
            }
            this.onload = true;
            console.log(this.fileData); 
        }  
    }

    
    submitHandler(){
        const {base64, fileName, recordId} = this.fileData;
        uploadAttachments({base64, fileName, recordId})
        .then( result => {
            console.log('ContentDocumentLink Id => ', result);
            this.onload = false;
            this.showToastMessage(fileName);

            const message = {refreshData : 'Yes'}
            publish(this.context, FileMessageChannel, message);
        }).catch( error => {
            console.log(error.body.message);
        })
    }

    showToastMessage(fileName){
        this.dispatchEvent(new ShowToastEvent({
            title: "Success",
            message: `${fileName} is successfully uploaded !!!`,
            variant: "success"
        }));
    }
}