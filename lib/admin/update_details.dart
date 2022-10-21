import 'package:flutter/material.dart';
import 'package:su_library/models/database.dart';
import 'package:su_library/models/userData.dart';
import 'package:su_library/shared/constants.dart';

class updateDetails extends StatefulWidget {

  @override
  State<updateDetails> createState() => _updateDetailsState();
}

class _updateDetailsState extends State<updateDetails> {

  String oldPassword = '';
  String newUsername = '';
  String newPassword = '';
  String error = '';
  String adminID = "xOlXWcAOtOqbFiVBKGnR";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserDataAdmin>(
      stream: DatabaseServiceAdmin(uid: adminID).userInfo,
      builder: (context, snapshot) {
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
                        Text('Update your Details', style: TextStyle(fontSize: 25.0),),
                        SizedBox(height: 20.0,),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(hintText: 'Enter current password',),
                          validator: (val) => val.isEmpty ? 'Required' : null,
                          obscureText: true,
                          onChanged: (val) {
                            setState(() => oldPassword = val);
                          },
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(hintText: 'Enter new username'),
                          validator: (val) => val.isEmpty ? 'Required' : null,
                          onChanged: (val) {
                            setState(() => newUsername = val);
                          },
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(hintText: 'Enter new password',),
                          validator: (val) => val.isEmpty ? 'Required' : null,
                          obscureText: true,
                          onChanged: (val) {
                            setState(() => newPassword = val);
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
                                  if(oldPassword == snapshot.data.password) {
                                    await DatabaseServiceAdmin(uid: adminID)
                                        .updateAdminData(
                                        newUsername, newPassword);
                                    Navigator.pop(context);
                                  }
                                  else{
                                    setState(() {
                                      error = 'Wrong password';
                                    });
                                  }
                                }
                              },
                              child: Text('Update'),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          error,
                          style: TextStyle(color: Colors.red, fontSize: 14.0),
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
    );
  }
}
