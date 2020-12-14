class User {

  User({this.uid});
  final String uid;

}

class UserData{
  final String uid;
  final String name;
  final int phonenumber;
  final int age;

  UserData({this.uid, this.name, this.age, this.phonenumber});
}

class Details {
  final String name;
  final int phonenumber;
  final int age;

  Details({this.name,this.phonenumber,this.age});

}