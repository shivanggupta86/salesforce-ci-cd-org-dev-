import { LightningElement, wire, track } from 'lwc';
import sendDataToClient from '@salesforce/apex/newsAppHandler.sendDataToClient';
import saveNews from '@salesforce/apex/newsAppHandler.saveNews';
import getNews from '@salesforce/apex/newsAppHandler.getNews';
import deleteBookmark from '@salesforce/apex/newsAppHandler.deleteBookmark';
import deleteAll from '@salesforce/apex/newsAppHandler.deleteAll';
import { NavigationMixin } from 'lightning/navigation';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';

export default class NewsApp extends NavigationMixin(LightningElement) {
    articles = [];
    isIndiaSelected = false;
    isUSASelected = false;
    isUKSelected = false;
    showData = false;
    isLoaded = true;
    showModal = false;
    savedNews = [];
    showTable = false;
    countryList = [
        { name: "India", code: "in" },
        { name: "USA", code: "us" },
        { name: "UK", code: "gb" },
    ]
    
    handleClick(event) {
        const { title } = event.target;
        console.log('title : ', title)
        if (title == 'India') {
            this.isIndiaSelected = !this.isIndiaSelected;
            if (this.isUSASelected || this.isUKSelected) {
                this.isUSASelected = false;
                this.isUKSelected = false;
            }
            if (this.isIndiaSelected) {
                this.getDataFromApi(title);

            } else {
                this.showData = false;
                this.articles = ''
            }
            console.log('code => ', code);
        }
        else if (title == 'USA') {
            this.isUSASelected = !this.isUSASelected;
            if (this.isIndiaSelected || this.isUKSelected) {
                this.isIndiaSelected = false;
                this.isUKSelected = false;
            }
            if (this.isUSASelected) {
                this.getDataFromApi(title);
            } else {
                this.showData = false;
                this.articles = ''
            }

        }
        else if (title == 'UK') {
            this.isUKSelected = !this.isUKSelected;
            if (this.isUSASelected || this.isIndiaSelected) {
                this.isUSASelected = false;
                this.isIndiaSelected = false;
            }
            if (this.isUKSelected) {
                this.getDataFromApi(title);
            } else {
                this.showData = false;
                this.articles = ''
            }

        }
    }

    getDataFromApi(title) {
        this.showData = true;
        this.isLoaded = false;
        this.countryList.forEach(item => {
            if (item.name == title) {
                this.searchHandler(item.code);
            }
        })
    }

    searchHandler(code) {
        sendDataToClient({ keyword: code })
            .then(result => {
                console.log('Data Received From API => ',JSON.parse(result).articles);
                const receivedData = [...JSON.parse(result).articles]
                this.articles = receivedData.filter( item => item.urlToImage != null)
                console.log('Final articles => ', this.articles)
                if(this.articles){
                    this.isLoaded = true;
                }
            }).catch(error => {
                console.log(error);
            })
    }

    


    readMoreHandler(event){
        const {title} = event.target;
        this[NavigationMixin.Navigate]({
            "type" : "standard__webPage",
            "attributes" : {
                "url" : title
            }
        });
    }

    saveHandler(event){
        
        let newsTitle = event.target.title;
        this.articles.forEach( item => {
            if(newsTitle == item.title){
                const saveArticle = {
                    Name: item.title, 
                    newsURL__c : item.url, 
                    Source__c : item.source.name
                }
                console.log('Saved Article =>',saveArticle);
                saveNews({article : saveArticle})
                .then( result => {
                    console.log(result);
                    this.showToastMessage('Article is saved', item.title ,'success');
                }).catch( error => {
                    this.showToastMessage(error.body.message, '' ,'error');
                })
            }
        })
        
    }
    
    handleModal(){
        this.showModal = !this.showModal
        if(this.showModal){
            this.getNewsMethod();
        }
        
    }
    getNewsMethod(){
        getNews({})
            .then( result => {
                if(result.length == 0){
                    this.showTable = false;
                }else{
                    this.showTable = true;
                    this.savedNews = result;
                    console.log('savedNews => ', this.savedNews);
                }
                
            })
    }

    deleteHandler(event){
        let recId = event.target.title;
        if(recId){
            const articlIds = [];
            articlIds.push(recId);
            deleteBookmark({articleIdList : articlIds})
            .then( result => {
                refreshApex(this.getNewsMethod());
                if(result != '' && result != null){
                    this.showToastMessage('Bookmark is removed', '','success')
                }
                
            }).catch(error => {
                console.log(error.body.message);
            })
        }
    }

    deleteAllHandler(){
        deleteAll().then( result => {
            refreshApex(this.getNewsMethod());
            if(result != '' && result != null){
                this.showToastMessage('All Bookmarks are deleted', '','success')
            }
            
        }).catch(error => {
            console.log(error.body.message);
        })
            
    }
    
    showToastMessage(title, message, variant){
        const toastMessage = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant
        });

        this.dispatchEvent(toastMessage);
    }
}