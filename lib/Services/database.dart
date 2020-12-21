import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rapidkl/Services/User.dart';

class DatabaseService {

  final String uid;

  DatabaseService({this.uid});

  //collection reference

  final CollectionReference userCollection = Firestore.instance.collection('users');
  final CollectionReference profileCollection = Firestore.instance.collection('profilepics');


  Future UpdateUserData(String name, String phonenumber, int age) async {
    return await userCollection.document(uid).setData({'name': name, 'phonenumber': phonenumber, 'age': age , });
  }

  Future UpdateProfilePic(String profilepic) async {
    return await profileCollection.document(uid).setData({'profilepic' : profilepic});
  }





  //list from snapshot

  List<Details> _listFRsnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Details(
        name: doc.data['name'] ?? '',
        phonenumber: doc.data['phonenumber'] ?? '01234567899',
        age: doc.data['age'] ?? 0,

      );
    }).toList();
  }

  //userdata from snapshot
  UserData _userdatafrSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      age: snapshot.data['age'],
      phonenumber: snapshot.data['phonenumber'],
    );
  }

  Stream<List<Details>> get user {
    return userCollection.snapshots().map(_listFRsnapshot);
  }

  Stream<UserData> get userData{
    return userCollection.document(uid).snapshots().map(_userdatafrSnapshot);
  }


  //profile pic
  UserProfilePic _userprofilepic(DocumentSnapshot snapshot) {
    return UserProfilePic(
      profilepic: snapshot.data['profilepic'],
    );
  }

  Stream<UserProfilePic> get userProfilePic{
    return profileCollection.document(uid).snapshots().map(_userprofilepic);
  }

  //news



}

class UserNews {


  final String docname;

  UserNews({this.docname});

  final CollectionReference newsCollection = Firestore.instance.collection('news');

  NewsFunc _news(DocumentSnapshot snapshot) {
    return NewsFunc(
      news : snapshot.data['lmao'],
    );
  }

  Stream<NewsFunc> get newsstuff{
    return newsCollection.document(docname).snapshots().map(_news);
  }

}