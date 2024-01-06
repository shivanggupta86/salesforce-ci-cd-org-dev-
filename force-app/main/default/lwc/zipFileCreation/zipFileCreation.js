import { LightningElement, api, track } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import getFiles from '@salesforce/apex/ZipFileCreationHandler.getFiles';
export default class ZipFileCreation extends NavigationMixin(LightningElement) {
    @api recordId;
    @track fileIds = '';
    @api invoke() {
        console.log('### I am here!');

        getFiles({
            recordId:this.recordId
        })
            .then(result => {
                console.log('result : ', result); 
                let fileList = result;
                if (fileList != '') { 
                    for (let i in fileList) { 
                        this.fileIds += fileList[i] + '/';
                    }
                }

                console.log('filesIds :', this.fileIds);
                
                if (this.fileIds.length > 0) { 
                    this.fileIds = this.fileIds.replace(/.$/,"?");
                }
                console.log('fileIds Modified : ', this.fileIds);

                const config = {
                    type: 'standard__webPage',
                    attributes: {
                        url: '/sfc/servlet.shepherd/version/download/' + this.fileIds
                    }
                };
                console.log('config : ', JSON.stringify(config))
                this[NavigationMixin.Navigate](config);

            })
            .catch(error => {
                console.log('### Error: ' + JSON.stringify(error));
             })
    }
}