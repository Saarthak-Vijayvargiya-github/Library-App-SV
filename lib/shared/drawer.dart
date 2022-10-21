import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:su_library/admin/addBook.dart';
import 'package:su_library/admin/update_details.dart';
import 'package:su_library/shared/auth.dart';

class OurDrawer extends StatefulWidget {

  @override
  State<OurDrawer> createState() => _OurDrawerState();
}

class _OurDrawerState extends State<OurDrawer> {
  @override
  Widget build(BuildContext context) {

    void _goToAddBook() {
      Navigator.push(context, MaterialPageRoute(builder: (context) => addBook()));
    }
    void _goToUpdateDetails() {
      Navigator.push(context, MaterialPageRoute(builder: (context) => updateDetails()));
    }
    Widget drawList;

    final user = FirebaseAuth.instance.currentUser;
    final AuthService _auth = AuthService();

    String _adminName = 'SUTT Admin';
    String img = 'https://lh3.googleusercontent.com/a-/AFdZucoio2dKUkfnpFE12HDoq-K-3HLNeg2ac96gKjoe=s40-p';  // For SUTT logo

    if(!(user.isAnonymous)){    // Drawer for Student
      drawList = Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/draw_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green[600],
              ),
              accountName: Text(user.displayName),
              accountEmail: Text(user.email),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.red,
                backgroundImage: NetworkImage(user.photoURL),
              ),
            ),
            ListTile(
              title: Text('Sign Out'),
              trailing: Icon(Icons.cancel_outlined),
              onTap: () async{
                Navigator.pop(context);
                await _auth.signOut();
              },
            ),
            ListTile(
              title: Text('Close'),
              trailing: Icon(Icons.arrow_back),
              onTap: () async{
                Navigator.pop(context);
              },
            ),
            SizedBox(height: 20.0,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text('Note:- You can issue as many books you want but can return only the book(s) issued by you.',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
        ),
      );
    }
    else{       // Drawer for Admin
      drawList = Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/draw_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green[600],
              ),
              accountName: Text(_adminName),
              accountEmail: Text('No email'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.red,
                backgroundImage: NetworkImage(img),
              ),
            ),
            ListTile(
              title: Text('Add a book'),
              trailing: Icon(Icons.add),
              onTap: () {
                Navigator.pop(context);
                _goToAddBook();
              },
            ),
            ListTile(
              title: Text('Sign Out'),
              trailing: Icon(Icons.cancel_outlined),
              onTap: () async{
                Navigator.pop(context);
                await _auth.signOut();
              },
            ),
            ListTile(
              title: Text('Close'),
              trailing: Icon(Icons.arrow_back),
              onTap: () async{
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Update username and password'),
              trailing: Icon(Icons.update),
              onTap: () async{
                Navigator.pop(context);
                _goToUpdateDetails();
              },
            ),
            SizedBox(height: 20.0,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text('Note:- Click the Book tile to update/delete the book.',
              style: TextStyle(
                fontSize: 18.0,
              ),
              ),
            ),
            SizedBox(height: 20.0,),
          ],
        ),
      );
    }

    return drawList;

  }
}

