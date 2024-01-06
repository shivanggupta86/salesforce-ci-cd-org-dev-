import { LightningElement } from 'lwc';

export default class ContactAndAccount extends LightningElement {
    showTable = false;
    createContact(event) {
        this.showTable = !this.showTable;

        /* const elem = this.template.querySelector('.tableId')
        console.log('elem',elem)
        let rowCount = elem.rows.length;
        console.log(rowCount)
        let row = elem.insertrow(rowCount) */
        // Get a reference to the table body element
        const tableBody = this.template.querySelector('.body');
        console.log('tableBody : ', tableBody)
        // Create a new row
        const newRow = tableBody.insertRow();

        // Create cells for each column
        const firstNameCell = newRow.insertCell();
        const lastNameCell = newRow.insertCell();
        const emailCell = newRow.insertCell();
        const dobCell = newRow.insertCell();

        // Set the values for each cell
        firstNameCell.innerHTML = 'Shivang';
        lastNameCell.innerHTML = 'Gupta';
        emailCell.innerHTML = 'shivanggupta@gmail.com';
        dobCell.innerHTML = '01/02/1993';

    }
}