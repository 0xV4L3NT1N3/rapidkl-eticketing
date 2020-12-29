import 'package:firebase_auth/firebase_auth.dart';
import 'package:rapidkl/Services/User.dart';
import 'package:rapidkl/Services/database.dart';
import 'package:get/get.dart';
import 'package:rapidkl/Pages/signin.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user obj based on FireBase user//

  User _userfrFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //create a stream when auth user change is detected//

  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userfrFirebaseUser);
  }

  Future signinanon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userfrFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  //sign in email//

  Future signin(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userfrFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register//
  Future signinemp(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;

      await DatabaseService(uid: user.uid).UpdateUserData(
        'Name',
        '01234567899',
        0,
      );
      await DatabaseService(uid: user.uid).UpdateProfilePic(
          'https://www.nailseatowncouncil.gov.uk/wp-content/uploads/blank-profile-picture-973460_1280.jpg');
      await DatabaseService(uid: user.uid).UpdateFavourites(
          ['Home', 'Work', 'School', 'Misc', 'Misc'],
          ['Home', 'Work', 'School', 'Misc', 'Misc']);
      return _userfrFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out//

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future sendpasswordresetemail(String email) async {
    await _auth.sendPasswordResetEmail(email: email).then((value) {
      Get.offAll(SignIn());
      Get.snackbar("Password Reset email link is been sent", "Success");
    }).catchError(
        (onError) => Get.snackbar("Error In Email Reset", onError.message));
  }
}
