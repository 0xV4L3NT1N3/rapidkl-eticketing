import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rapidkl/Services/User.dart';

class DatabaseService {

  final String uid;

  DatabaseService({this.uid});

  //collection reference

  final CollectionReference userCollection = Firestore.instance.collection('users');

  Future UpdateUserData(String name, String phonenumber, int age, String profilepic) async {
    return await userCollection.document(uid).setData({'name': name, 'phonenumber': phonenumber, 'age': age , 'profilepic' : profilepic});
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
      profilepic : snapshot.data['profilepic'] ?? 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.business2community.com%2Fsocial-media%2Fimportance-profile-picture-career-01899604&psig=AOvVaw3LRqkJhA7EKlfayr5sKbLp&ust=1608544132732000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCNiT5P-j3O0CFQAAAAAdAAAAABAD',
    );
  }

  Stream<List<Details>> get user {
    return userCollection.snapshots().map(_listFRsnapshot);
  }

  Stream<UserData> get userData{
    return userCollection.document(uid).snapshots().map(_userdatafrSnapshot);
  }
}