import 'package:flutter/material.dart';
import 'package:su_library/models/bookData.dart';
import 'package:su_library/models/bookDatabase.dart';
import 'package:provider/provider.dart';
import 'package:su_library/shared/books_tile.dart';
import 'package:su_library/shared/drawer.dart';

class StudentHome extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return StreamProvider<List<BookDoc>>.value(
      initialData: [],
      value: UpdateBook().booksList,
      child: Scaffold(
        backgroundColor: Colors.black12,
        appBar: AppBar(
          backgroundColor: Colors.pink[400],
          title: Text('SU Library - Books'),
        ),
        drawer: Drawer(
          child: OurDrawer(),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/lib_bg2.jpg'),
              fit: BoxFit.cover,
            ),
          ),
            child: BookList(),
        ),
      ),
    );
  }
}

class BookList extends StatefulWidget {
  @override
  State<BookList> createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  @override
  Widget build(BuildContext context) {
    final books = Provider.of<List<BookDoc>>(context);
    return ListView.builder(
        itemCount: books.length ?? [],
        itemBuilder: (context, index){
          return BooksTile(book: books[index]);
        }
    );
  }
}
