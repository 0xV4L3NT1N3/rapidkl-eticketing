import 'package:flutter/material.dart';
import 'package:rapidkl/Services/User.dart';
import 'package:rapidkl/Services/services.dart';
import 'package:rapidkl/Services/database.dart';
import 'package:provider/provider.dart';


class Profile extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<Profile> {
  @override

  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();


  //variables for user details
  String _currentname;
  int _phonenumber;
  int _age;

  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body : Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Container(
              child: FlatButton(
                color: Colors.white,
                child: Text('Sign Out'),
                onPressed: () async {
                  await _auth.signOut();
                },
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 90.0,
                backgroundColor: Colors.grey[400],
                foregroundColor: Colors.grey[400],
              )
            ],
          ),
          Text('Profile Picture',style: TextStyle(fontSize: 20.0),),
          SizedBox(height : 50.0),
          StreamBuilder <UserData>(
              stream: DatabaseService(uid: user.uid).userData,
              builder: (context , snapshot) {
                if (snapshot.hasData) {}

                else {}
              }
          ),

        ],
      )
    );
  }
}