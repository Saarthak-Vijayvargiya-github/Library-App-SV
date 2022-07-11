import 'package:flutter/material.dart';
import 'package:su_library/shared/auth.dart';
import 'package:su_library/shared/constants.dart';
import 'package:su_library/shared/loading.dart';
// import 'package:su_library/student/home.dart';
// import 'package:http/http.dart';

class AdminSignIn extends StatefulWidget {

  final Function toggleView;
  AdminSignIn({this.toggleView});
  @override
  State<AdminSignIn> createState() => _AdminSignInState();
}

class _AdminSignInState extends State<AdminSignIn> {

  String error = '';
  String name = '';
  String password = '';
  bool loading = false;

  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  var nameController = TextEditingController();
  var passController = TextEditingController();

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
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Image(image: AssetImage('assets/logo.png'),),
                    SizedBox(height: 10.0,),
                    Text(
                      'Admin Log In',
                      style: TextStyle(fontSize: 25.0,),
                    ),
                    SizedBox(height: 20.0,),
                    TextFormField(
                      controller: nameController,
                      decoration: textInputDecoration.copyWith(hintText: 'Username'),
                      // textInputDecoration is present in shared/constants.dart
                      validator: (val) => val.isEmpty ? 'Required' : null,
                      onChanged: (val) {
                        setState(() => name = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: passController,
                      decoration: textInputDecoration.copyWith(hintText: 'Password'),
                      obscureText: true,
                      validator: (val) => val.isEmpty ? 'Required' : null,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    MaterialButton(
                      color: Colors.pink,
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            loading = true;
                          });
                          dynamic response = await _auth.adminLogin(nameController.text, passController.text);
                          if(response == null){
                            setState((){
                              loading = false;
                              error = 'Invalid Credentials';
                            });
                          }
                        }
                      },
                      child: Text('Login'),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    // SizedBox(height: 12.0),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                    MaterialButton(
                      onPressed: () {
                        widget.toggleView();
                      },
                      child: Text("If you are an Student, Sign In here",
                        style: TextStyle(
                          color: Colors.grey[700],
                        ),),
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