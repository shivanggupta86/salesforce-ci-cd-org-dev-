import { LightningElement, wire } from 'lwc';
import getCreditCards from '@salesforce/apex/CreditCardToLWC.getCreditCards';
import { NavigationMixin } from 'lightning/navigation';
export default class CreditCard extends NavigationMixin(LightningElement) {
    cardData;
    connectedCallback() {
        getCreditCards().then(result => {
            console.log(result);
            this.cardData = result ;
        }).catch(error =>{
            console.log(error);
        })
    }

    applyHandler(){
        this[NavigationMixin.Navigate]({
            "type": "standard__webPage",
            "attributes": {
                "url": "https://www.idbibank.in/royal-credit-card.aspx#howToApply"
            }
        });
        /* this[NavigationMixin.Navigate]({
            "type": "standard__webPage",
            "attributes": {
                "url": "https://www.idbibank.in/royal-credit-card.aspx#howToApply"
            }
        }); */
        
    }

    knowMoreHandler(){
        const cardName = this.template.querySelector('.knowMore').title;
        let knowMoreURL;
        this.cardData.forEach(item => {
            if(cardName === item.Name){
                knowMoreURL = item.KnowMore_URL__c;
            }
        })
        
        this[NavigationMixin.Navigate]({
            "type": "standard__webPage",
            "attributes": {
                "url": knowMoreURL
            }
        });
    }
}