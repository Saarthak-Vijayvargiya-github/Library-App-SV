import 'package:flutter/material.dart';
import 'package:su_library/shared/auth.dart';
import 'package:su_library/shared/constants.dart';
import 'package:su_library/shared/loading.dart';

class StudentSignIn extends StatefulWidget {

  final Function toggleView;          // Used to toggle between admin and student sign in
  StudentSignIn({this.toggleView});   // This function is present in shared/authenticate.dart
  @override
  State<StudentSignIn> createState() => _StudentSignInState();
}

class _StudentSignInState extends State<StudentSignIn> {

  final AuthService _auth = AuthService();

  String error = '';          // To show error message
  String email = '';
  String password = '';
  bool loading = false;       // To control loading screen

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
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
                child: Column(
                  children: <Widget>[
                    Image(image: AssetImage('assets/logo.png'),),
                    SizedBox(height: 10.0,),
                    Text(
                      'Log In',
                    style: TextStyle(fontSize: 25.0,),
                    ),
                    SizedBox(height: 20.0,),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(hintText: 'Email', prefixIcon: Icon(Icons.alternate_email)),
                      // textInputDecoration is present in shared/constants.dart
                      validator: (val) => val.isEmpty ? 'Required' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(hintText: 'Password', prefixIcon: Icon(Icons.lock)),
                      obscureText: true,
                      validator: (val) => val.isEmpty ? 'Required' : null,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    MaterialButton(
                      color: Colors.pink,
                      onPressed: () {
                        showDialog<String>(
                            context: context,
                            builder: (context) => AlertDialog(
                              content: Text('Sorry! This service is not available'),
                              actions: [
                                TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text('Okay!'),
                                ),
                              ],
                            )
                        );
                      },
                      child: Text('Register'),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    MaterialButton(
                      onPressed: () async{
                        setState(() {
                          loading = true;
                        });
                        dynamic result = await _auth.signIn();
                        if (result == null) {
                          setState(() {
                            loading = false;
                            error = 'Invalid Credentials';
                          });
                        }
                        print(result);
                      },
                      color: Colors.lightGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(image: AssetImage('assets/google_logo.png'), height: 25.0,),
                          SizedBox(width: 15.0),
                          Text('Sign In With your Google account'),
                        ],
                      ),
                    ),
                    MaterialButton(
                        onPressed: () {
                          widget.toggleView();
                        },
                        child: Text("If you are an Admin, Sign In here",
                        style: TextStyle(
                          color: Colors.grey[700],
                          ),
                        ),
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
