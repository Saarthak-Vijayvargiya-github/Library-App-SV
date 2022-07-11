import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:su_library/admin/settings_form.dart';
import 'package:su_library/models/bookData.dart';
import 'package:su_library/models/bookDatabase.dart';

class BooksTile extends StatelessWidget {
  final BookDoc book;
  BooksTile({this.book});

  @override
  Widget build(BuildContext context) {

    final user = FirebaseAuth.instance.currentUser;

    void _showSettingsPanel(String uid) {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
          child: SettingsForm(uid: uid),
        );
      });
    }
    final bool value = (book.status == true) ? true : false;
    return Card(
      margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 6.0),
      child: ListTile(
        leading: (user.isAnonymous) ? null : Checkbox(
            side: BorderSide(
              color: Colors.green,
              width: 2.0,
            ),
            activeColor: Colors.green,
            value: value,
            onChanged: (value) async{
              if(book.status == false) {
                  await UpdateBook(uid: book.uid).updateBookData(
                      book.name, book.author, !book.status, user.email);
              }
              else{
                if ((user.email == book.email)) {
                  await UpdateBook(uid: book.uid).updateBookData(
                      book.name, book.author, !book.status, '');
                }
              }
            },
          ),
          title: Text(book.name),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(book.author),
              Text(book.status ? 'Issued by ${book.email}' : 'Not issued'),
            ],
          ),
          onTap: () {
            (!(user.isAnonymous)) ? null : _showSettingsPanel(book.uid);
            // Only Admin is allowed to update book details
          }
      ),
    );
  }
}
