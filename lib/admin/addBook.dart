import 'package:flutter/material.dart';
import 'package:su_library/models/bookDatabase.dart';
import 'package:su_library/shared/constants.dart';


class addBook extends StatefulWidget {

  @override
  State<addBook> createState() => _addBookState();
}

class _addBookState extends State<addBook> {

  String bookName;
  String bookAuthor;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/main_bg.jpg'),
              fit: BoxFit.cover,
            )
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20.0),
            child: Container(
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 10.0,
                      spreadRadius: 1.0,
                      offset: Offset(4.0, 4.0),
                    )
                  ]),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Text('Add a Book', style: TextStyle(fontSize: 25.0),),
                    SizedBox(height: 20.0,),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(hintText: 'Name'),
                      validator: (val) => val.isEmpty ? 'Required' : null,
                      onChanged: (val) {
                        setState(() => bookName = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(hintText: 'Author'),
                      validator: (val) => val.isEmpty ? 'Required' : null,
                      onChanged: (val) {
                        setState(() => bookAuthor = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MaterialButton(
                          color: Colors.pink,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Back'),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        MaterialButton(
                          color: Colors.green,
                          onPressed: () async{
                              if(_formKey.currentState.validate()){
                                await BookService().addBookData(bookName, bookAuthor, false, '');
                                Navigator.pop(context);
                              }
                              },
                          child: Text('Add'),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
