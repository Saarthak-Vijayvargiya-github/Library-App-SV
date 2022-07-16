import 'package:flutter/material.dart';
import 'package:su_library/admin/admin_sign_in.dart';
import 'package:su_library/user/student_sign_in.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

// Just to toggle between student and admin sign in screens

class _AuthenticateState extends State<Authenticate> {

  bool showStudentSignIn = true;
  void toggleView() {
    setState(() => showStudentSignIn = !showStudentSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if(showStudentSignIn){
      return StudentSignIn(toggleView: toggleView);
    }
    else{
      return AdminSignIn(toggleView: toggleView);
    }
  }
}