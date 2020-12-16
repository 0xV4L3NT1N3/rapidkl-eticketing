import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rapidkl/Services/User.dart';

class DatabaseService {

  final String uid;

  DatabaseService({this.uid});

  //collection reference

  final CollectionReference userCollection = Firestore.instance.collection('users');

  Future UpdateUserData(String name, String phonenumber, int age, ) async {
    return await userCollection.document(uid).setData({'name': name, 'phonenumber': phonenumber, 'age': age});
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
}