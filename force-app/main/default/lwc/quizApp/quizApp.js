import { LightningElement } from 'lwc';

export default class QuizApp extends LightningElement {
    selected = {} //for stroing answers
    correctAnswers = 0; //to show the result
    isSubmitted = false; // use to show number of correct answers

    //for applying dynamic styling to our result
    get isScoredFull(){
        return `slds-text-heading_large ${this.myQuestion.length === this.correctAnswers?
            'slds-text-color_success':'slds-text-color_error'}`
    }
    get allNotSelected(){
        return !(Object.keys(this.selected).length === this.myQuestion.length);
    }
    myQuestion = [
        {
            id : "Question 1",
            question : "Which one of the following is the CEO of Google?",
            ans : {
                a: "Sundai Pichai",
                b: "Satya Nadela",
                c: "Sunit Mittal",
                d:  "Tim Cook"
            },
            correctAnswer : 'a'
        },
        {
            id : "Question 2",
            question : "Which one of the following is the CEO of Apple?",
            ans : {
                a: "Sundai Pichai",
                b: "Satya Nadela",
                c: "Sunit Mittal",
                d:  "Tim Cook"
            },
            correctAnswer : 'd'
        },
        {
            id : "Question 3",
            question : "Which one of the following is the CEO of Microsoft?",
            ans : {
                a: "Sundai Pichai",
                b: "Satya Nadela",
                c: "Sunit Mittal",
                d:  "Tim Cook"
            },
            correctAnswer : 'b'
        },
        {
            id : "Question 4",
            question : "Which one of the following is the CEO of Twitter?",
            ans : {
                a: "Sundai Pichai",
                b: "Satya Nadela",
                c: "Parag Agrawal",
                d:  "Tim Cook"
            },
            correctAnswer : 'c'
        },
        {
            id : "Question 5",
            question : "Which one of the following is the CEO of Tesla?",
            ans : {
                a: "Sundai Pichai",
                b: "Elon Musk",
                c: "Sunit Mittal",
                d:  "Tim Cook"
            },
            correctAnswer : 'b'
        }
    ]
    
    //changeHanler gets called on every click on the options
    changeHandler(event){
        console.log('Name', event.target.name);
        console.log('Value', event.target.value);
        const {name, value} = event.target;
        //const name = event.target.name;
        //const value = event.target.value;

        //selected{} is a blank object, where we will store the data which we are getting when we click on any radio button
        //When we click on radio button we are getting 'Name' and 'value' of the radio button Where in Name we are
        //storing Id(question1,2,3....) and in Value we are stroing marked option (a,b,c,d...). So if we want to store 
        //both the things at same place, Storing them in an blank object is the best option.
        
        this.selected = {...this.selected, [name] : value};
    }
    
    //for submit handler
    submitHandler(event){
        //to prevent refresh of page
        event.preventDefault()
        //filter always returns an array
        let correct = this.myQuestion.filter(item => this.selected[item.id] === item.correctAnswer);
        this.correctAnswers = correct.length; // getting number of correct answers
        console.log('Correct Answers length', this.correctAnswers);
        this.isSubmitted = true;
    }

    //for resetHandler
    resetHandler(){
        this.selected = {};
        this.correctAnswers = 0;
        this.isSubmitted = false;
    }
    
}