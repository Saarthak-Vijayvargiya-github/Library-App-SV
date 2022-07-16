import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:su_library/models/userData.dart';
import 'package:su_library/shared/authenticate.dart';
import 'package:su_library/user/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserData>(context);
    // return either the Home or sign in screens
    if(user == null){
      return Authenticate();
    }
    else{
      return StudentHome();
    }
  }
}