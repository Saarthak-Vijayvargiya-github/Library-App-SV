import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:su_library/models/database.dart';
import 'package:su_library/models/userData.dart';
import 'package:http/http.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserData _fromFirebaseUser(User user) {
    return user != null
        ? UserData(uid: user.uid, fullName: user.displayName)
        : null;
  }

  Stream<UserData> get user {
    return _auth.authStateChanges().map((User user) => _fromFirebaseUser(user));
  }

  // Sign In with Google
  Future<UserCredential> signIn() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    UserData _userData = UserData();
    try {
      GoogleSignInAccount googleUser = await googleSignIn.signIn();
      GoogleSignInAuthentication gSA = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: gSA.idToken,
        accessToken: gSA.accessToken,
      );

      UserCredential userCredential = await _auth.signInWithCredential(
          credential);
      if (userCredential.additionalUserInfo.isNewUser) {
        _userData.uid = userCredential.user.uid;
        _userData.fullName = userCredential.user.displayName;
        DatabaseService().updateUserData(_userData);
      }
      return userCredential;
    }
    catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Create function to call login post API
  // Future<dynamic> adminLogin(String name, String pass) async{
  //   var response = await post(Uri.parse("https://sids438.pythonanywhere.com/login/"), body: ({
  //     "username": name,
  //     "password": pass,
  //   }));
  //   print(response.body);
  //   if (response.statusCode != 200) {
  //       return null;
  //   }
  //   else{
  //     // Anonymous Sign in was only the option for admin as there was no way for API login
  //     try {
  //       UserCredential result = await _auth.signInAnonymously();
  //       User user = result.user;
  //       UserData _userData = UserData();
  //       _userData.uid = user.uid;
  //       _userData.fullName = 'SUTT Admin';
  //       await DatabaseService(uid: user.uid).updateUserData(_userData);
  //       return _fromFirebaseUser(user);
  //     } catch (e) {
  //       print(e.toString());
  //       return null;
  //     }
  //   }
  //
  // }

  // Fuction for Firestore database login
  Future<dynamic> adminLogin(String name, String pass, UserDataAdmin admin) async {
    if (name == admin.username && pass == admin.password) {
      // Anonymous Sign in was only the option for admin as there was no way for API login
      try {
        UserCredential result = await _auth.signInAnonymously();
        User user = result.user;
        UserData _userData = UserData();
        _userData.uid = "AdMiNlOgGeDiN";
        _userData.fullName = 'SUTT Admin';
        await DatabaseService(uid: _userData.uid).updateUserData(_userData);
        return _fromFirebaseUser(user);
      } catch (e) {
        print(e.toString());
        return null;
      }
    }
    else {
      return null;
    }
  }


  // Sign Out
  Future signOut() async {
    try {
      return await _auth.signOut();
    }
    catch (e) {
      print(e.toString());
      return null;
    }
  }
}
