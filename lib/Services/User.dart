

class User {

  User({this.uid});
  final String uid;

}

class UserData{
  final String uid;
  final String name;
  final String phonenumber;
  final int age;

  UserData({this.uid, this.name, this.age, this.phonenumber});
}

class Details {
  final String name;
  final String phonenumber;
  final int age;

  Details({this.name,this.phonenumber,this.age});

}

class UserProfilePic{
  String profilepic;

  UserProfilePic({this.profilepic});
}

class NewsFunc{
  var news;
  var caption;
  var images;

  NewsFunc({this.news, this.caption, this.images});
}

class Favfunc {

  var keyarr;
  var valarr;

  Favfunc({this.keyarr, this.valarr});

}
