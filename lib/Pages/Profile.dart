import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
    );
  }
}