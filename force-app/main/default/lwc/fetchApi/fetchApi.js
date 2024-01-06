import { LightningElement } from 'lwc';
const BOOK_URL = 'https://www.googleapis.com/books/v1/volumes?q='
export default class fetchAPI extends LightningElement {

    bookName = 'Man';
    books = [];
    newData = {};
    timer;
    connectedCallback(){
        this.fetchBooks();
    }

    fetchBooks(){
        fetch(BOOK_URL + this.bookName)
        .then(response => response.json())
        .then(data => {
            this.books = data ? this.formatData(data) : [];
            console.log('this.books => ', this.books);
        })
        .catch(error => {
            console.log('error occured => ',error);
        })
    }

    ChangeHandler(event){
        this.bookName = event.target.value;
        if(this.bookName != ''){
            window.clearTimeout(this.timer)
            this.timer= setTimeout(()=>{
                this.fetchBooks()
            }, 2000)
        }
    }

    formatData(data){
        console.log(data);
        let booksData = data.items.map(item =>{
            
            let id = item.id;
            let author; 
            item.volumeInfo.authors ? item.volumeInfo.authors.forEach(item =>{author = item}) : author = 'N/A';
            let thumbnail = item.volumeInfo.imageLinks.thumbnail ? item.volumeInfo.imageLinks.thumbnail : 'N/A' ;
            let title = item.volumeInfo.title ? item.volumeInfo.title : 'N/A';
            let rating = item.volumeInfo.averageRating ? item.volumeInfo.averageRating : 'N/A';            
            return ({id, author, thumbnail, title, rating});
        })
        return booksData ;
    }
}