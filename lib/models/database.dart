import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:su_library/models/userData.dart';

class DatabaseService{
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference users = FirebaseFirestore.instance.collection('users');
  Future updateUserData(UserData userData) async{
    return await users.doc(uid).set({
      'fullName': userData.fullName,
    });
  }

  // If we want to get data of the user then we can make a stream and retrieve data
  // But this is not used in the app as of now

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
      return UserData(
        uid: uid,
        fullName: snapshot['fullName'] ?? '',
    );
  }

  Stream<UserData> get userInfo{
    return users.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

}