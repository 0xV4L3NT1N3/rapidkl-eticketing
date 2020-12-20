import 'package:firebase_auth/firebase_auth.dart';
import 'package:rapidkl/Services/User.dart';
import 'package:rapidkl/Services/database.dart';
import 'dart:io';


class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user obj based on FireBase user//

  User _userfrFirebaseUser(FirebaseUser user){
    return user != null ? User(uid : user.uid): null;
  }

  //create a stream when auth user change is detected//

  Stream<User>get user {
    return _auth.onAuthStateChanged. map(_userfrFirebaseUser );
  }

  Future signinanon() async {
    try{
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userfrFirebaseUser(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
  //sign in email//

  Future signin( String email, String password) async {
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userfrFirebaseUser(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

  //register//
  Future signinemp( String email, String password) async {
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;


      await DatabaseService( uid: user.uid).UpdateUserData('Name', '01234567899', 0 , 'https://cdn.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png');
      return _userfrFirebaseUser(user);

    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign out//

  Future signOut() async {
    try{
      return await _auth.signOut();
    }
    catch (e){
      print (e.toString());
      return null;
    }
}
}