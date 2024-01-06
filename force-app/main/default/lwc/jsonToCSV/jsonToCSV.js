import { LightningElement, wire } from 'lwc';
import getAccounts from '@salesforce/apex/JsonToCSVController.getAccounts'
import {exportCSVFile} from 'c/utils'
export default class JsonToCSV extends LightningElement {
    accountData;
    
    @wire(getAccounts)
    accountHandler({data}){
        if(data){
            console.log(data)
            this.accountData = data
        }
    }

    accountHeaders ={
        Id:"Record Id",
        Name:"Name",
        AnnualRevenue:"Annual Revenue",
        Industry:"Industry",
        Phone:"Phone"

    }

    headers = {
        username:"User Name",
        age:"Age",
        title:"Title"
    }

    downloadAccountData(){
        exportCSVFile(this.accountHeaders, this.accountData, "accounts detail")
    }
}