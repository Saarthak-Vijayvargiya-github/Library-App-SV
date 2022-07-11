import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:su_library/models/bookData.dart';

class BookService{         // This is just used to add data inside the Firestore

  Future addBookData(String name, String author, bool status, String email) async{
  // Document Reference
  await FirebaseFirestore.instance.collection('books').add({
      'name': name,
      'author': author,
      'status': status,
      'issued_by': email,
    });
  }
}

class UpdateBook{

  final String uid;
  UpdateBook({this.uid});
  final CollectionReference bookCollection = FirebaseFirestore.instance.collection('books');
  final bookDocument = FirebaseFirestore.instance.collection('books').doc();

  Future updateBookData(String name, String author, bool status, String email) async{
    return await bookCollection.doc(uid).set({
      'name': name,
      'author': author,
      'status': status,
      'issued_by': email,
    });
  }

  Future deleteBook() async{
    return await bookCollection.doc(uid).delete();
  }

  List<BookDoc> _list(QuerySnapshot snapshot){
    return snapshot.docs.map((doc) {
      return BookDoc(
        uid: doc.id,
        name: doc.get('name') ?? '',
        author: doc.get('author') ?? '',
        status: doc.get('status') ?? false,
        email: doc.get('issued_by') ?? '',
      );
    }).toList();
  }

  BookDoc _bookDataFromSnapshot(DocumentSnapshot snapshot){
    return BookDoc(
      uid: snapshot.id,
      name: snapshot['name'],
      author: snapshot['author'],
      status: snapshot['status'],
      email: snapshot['issued_by'] ?? '',
    );
}
  // Stream to get list of books
  Stream<List<BookDoc>> get booksList{
    return FirebaseFirestore.instance.collection('books').snapshots().map(_list);
  }

  // Stream to get data of a particular book
  Stream<BookDoc> get bookDoc{
    return bookCollection.doc(uid).snapshots().map(_bookDataFromSnapshot);
  }
}