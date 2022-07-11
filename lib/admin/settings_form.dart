import 'package:flutter/material.dart';
import 'package:su_library/models/bookData.dart';
import 'package:su_library/models/bookDatabase.dart';
import 'package:su_library/shared/constants.dart';
import 'package:su_library/shared/screens/loading.dart';


class SettingsForm extends StatefulWidget {
  final String uid;
  SettingsForm({this.uid});
  @override
  State<SettingsForm> createState() => _SettingsFormState(uid: uid);
}

class _SettingsFormState extends State<SettingsForm> {
  final String uid;
  _SettingsFormState({this.uid});
  final _formKey = GlobalKey<FormState>();

  String _currentName;
  String _currentAuthor;

  @override
  Widget build(BuildContext context) {


    return StreamBuilder<BookDoc>(
        stream: UpdateBook(uid: uid).bookDoc,
        builder: (context, snapshot){
         if(snapshot.hasData){
           BookDoc bookDoc = snapshot.data;
           return Form(
             key: _formKey,
               child: Column(
                 children: [
                   Text('Update Book Details',
                     style: TextStyle(fontSize: 20.0),
                   ),
                   SizedBox(height: 20.0,),
                   TextFormField(
                     decoration: textInputDecoration.copyWith(hintText: 'Name'),
                     initialValue: bookDoc.name,
                     validator: (val) => val.isEmpty ? 'Please enter a name' : null,
                     onChanged: (val) => setState(() => _currentName = val),
                   ),
                   SizedBox(height: 20.0,),
                   TextFormField(
                     decoration: textInputDecoration.copyWith(hintText: 'Author'),
                     initialValue: bookDoc.author,
                     validator: (val) => val.isEmpty ? 'Please enter author' : null,
                     onChanged: (val) => setState(() => _currentAuthor = val),
                   ),
                   SizedBox(height: 20.0,),
                   MaterialButton(
                     onPressed: () async{
                       if(_formKey.currentState.validate()){
                         await UpdateBook(uid: uid).updateBookData(
                           _currentName ?? bookDoc.name,
                           _currentAuthor ?? bookDoc.author,
                           bookDoc.status,
                           bookDoc.email,
                         );
                         Navigator.pop(context);
                       }
                     },
                     child: Text('Update'),
                     color: Colors.green,
                   ),
                   SizedBox(height: 20.0,),
                   MaterialButton(
                     onPressed: () async{
                       await UpdateBook(uid: uid).deleteBook();
                       Navigator.pop(context);
                       },
                     child: Text('Delete'),
                     color: Colors.red,
                   ),
                 ],
               ),
           );
         }
         else{
           return Loading();
         }
        }
    );
  }
}
