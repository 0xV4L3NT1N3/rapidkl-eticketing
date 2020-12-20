import 'dart:io';

class User {

  User({this.uid});
  final String uid;

}

class UserData{
  final String uid;
  final String name;
  final String phonenumber;
  final int age;
  final String profilepic;

  UserData({this.uid, this.name, this.age, this.phonenumber, this.profilepic});
}

class Details {
  final String name;
  final String phonenumber;
  final int age;

  Details({this.name,this.phonenumber,this.age});

}