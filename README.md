# su_library

Basic replica of a Library. 

## Getting Started
The App’s landing page consists of two login options. A user login and an admin login. 

After a succesful login, it shows a home page consisting a list of books with their details with a drawer.

### Login by user:-
User can login via their google account. 

User can issue/return books by a simple checkbox.

### Login by admin
Login Credentials:- username = SUTT_admin , password = 1234567890  (Login through Postman API)

Admin is logged in via an post api method and signed into the firebase anonymously.

Admin has the power to add books. This service can be accesed by the drawer.

He/She can also update the details of the book by clicking the book tile. A bottom sheet appears for this.

### Features:-
There is a check if the text fields are empty inside login page, add a book page and update book sheet.

Everyone including admin can know about the issue details of the book.

### Cons:-
The admin cannot issue/return the books.

Each time Admin signs in, signed by an anonymous account as there is no option in firebase for API login.
