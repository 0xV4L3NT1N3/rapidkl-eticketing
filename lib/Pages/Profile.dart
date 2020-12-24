import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:rapidkl/Services/User.dart';
import 'package:rapidkl/Services/services.dart';
import 'package:rapidkl/Services/database.dart';
import 'package:provider/provider.dart';
import 'package:rapidkl/Services/textdecoration.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class Profile extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<Profile> {
  File _image;

  String imageurl;

  int filename = 0;

  String profilepic;

  //Firebase storage instance
  final _storage = FirebaseStorage.instance;

  //Upload File
  UploadFile() async {
    var file = File(_image.path);
    var snapshot = await _storage
        .ref()
        .child(filename.toString())
        .putFile(file)
        .onComplete;
    var downloadurl = await snapshot.ref.getDownloadURL();

    setState(() {
      imageurl = downloadurl;
      filename = filename + 1;
    });
  }

//pick image from camera
  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  //pick image from gallery
  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  @override
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();

  //variables for user details
  String _errortext = '';
  String _currentname;
  String _phonenumber;
  int _age;
  Image myimage;

  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return SingleChildScrollView(
      child: Container(
        height: 700,
        width: 1000,
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title text
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0, left: 15.0),
                    child: Text(
                      'Profile',
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey[800]),
                    ),
                  ),

                  // Sign out icon
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0, left: 200.0),
                    child: Container(
                        child: IconButton(
                      icon: Icon(Icons.login, color: Colors.blueGrey[800]),
                      onPressed: () async {
                        await _auth.signOut();
                      },
                    )),
                  ),
                ],
              ),

              StreamBuilder<UserData>(
                  stream: DatabaseService(uid: user.uid).userData,
                  // ignore: missing_return
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      UserData userData = snapshot.data;
                      return Column(
                        children: [
                          //Profile picture
                          StreamBuilder<UserProfilePic>(
                              stream:
                                  DatabaseService(uid: user.uid).userProfilePic,
                              // ignore: missing_return
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  UserProfilePic userprofilepic = snapshot.data;
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        showModalBottomSheet(
                                            context: context,
                                            builder: (BuildContext bc) {
                                              return AnimatedContainer(
                                                  duration:
                                                      Duration(seconds: 10),
                                                  height: 200.0,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 20.0),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Column(children: [
                                                              IconButton(
                                                                  icon: Icon(
                                                                    Icons
                                                                        .camera_alt,
                                                                    size: 60.0,
                                                                  ),
                                                                  splashRadius:
                                                                      400.0,
                                                                  onPressed:
                                                                      () {
                                                                    _imgFromCamera();
                                                                  }),
                                                              Padding(
                                                                  padding: EdgeInsets.only(
                                                                      left:
                                                                          23.0,
                                                                      top:
                                                                          20.0),
                                                                  child: Text(
                                                                      'Take Picture')),
                                                            ]),
                                                            Column(children: [
                                                              IconButton(
                                                                  icon: Icon(
                                                                    Icons.photo,
                                                                    size: 60.0,
                                                                  ),
                                                                  splashRadius:
                                                                      400.0,
                                                                  onPressed:
                                                                      () {
                                                                    _imgFromGallery();
                                                                  }),
                                                              Padding(
                                                                  padding: EdgeInsets.only(
                                                                      left:
                                                                          40.0,
                                                                      top:
                                                                          20.0),
                                                                  child: Text(
                                                                      'Pick Image from Gallery')),
                                                            ]),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 30.0,
                                                        ),
                                                        RaisedButton(
                                                            child: Text(
                                                                'Update Profile Picture'),
                                                            onPressed:
                                                                () async {
                                                              Navigator.pop(
                                                                  context);
                                                              UploadFile();
                                                              await DatabaseService(
                                                                      uid: user
                                                                          .uid)
                                                                  .UpdateProfilePic(
                                                                      imageurl ??
                                                                          userprofilepic
                                                                              .profilepic);
                                                              setState(() {
                                                                imageCache
                                                                    .clear();
                                                              });
                                                            })
                                                      ],
                                                    ),
                                                  ));
                                            });
                                      });
                                    },
                                    child: FutureBuilder(
                                      future: DatabaseService(uid: user.uid)
                                          .UpdateProfilePic(imageurl ??
                                              userprofilepic.profilepic),
                                      builder: (context, snapshot) {
                                        return Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: CircleAvatar(
                                              backgroundColor: Colors.grey,
                                              radius: 80,
                                              child: ClipOval(
                                                  child: Image.network(
                                                userprofilepic.profilepic,
                                                height: 2000,
                                                width: 2500,
                                                fit: BoxFit.fill,
                                              ))),
                                        );
                                      },
                                    ),
                                  );
                                } else {
                                  return Container(
                                    width: 0.0,
                                    height: 0.0,
                                  );
                                }
                              }),

                          //Preferences
                          Column(
                            children: [
                              SingleChildScrollView(
                                child: Column(children: [
                                  //name tile
                                  ListTile(
                                    leading: Icon(Icons.person),
                                    title: Text(
                                      userData.name,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text('Name'),
                                    trailing: IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed: () {
                                        setState(() {
                                          showModalBottomSheet<void>(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Form(
                                                key: _formkey,
                                                child: Column(children: [
                                                  SizedBox(
                                                    height: 20.0,
                                                  ),
                                                  Text(
                                                    'Update Name',
                                                    style: TextStyle(
                                                      fontSize: 20.0,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 20.0,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            20.0, 0, 20.0, 0.0),
                                                    child: TextFormField(
                                                      initialValue:
                                                          userData.name,
                                                      decoration:
                                                          textinput.copyWith(
                                                        hintText: 'Name',
                                                        hintStyle: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      validator: (val) => val
                                                                  .length ==
                                                              0
                                                          ? "Please enter a name"
                                                          : null,
                                                      onChanged: (val) {
                                                        setState(() {
                                                          _currentname = val;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10.0,
                                                  ),
                                                  FlatButton(
                                                      color: Colors.pinkAccent,
                                                      child: Text('Update'),
                                                      onPressed: () async {
                                                        if (_formkey
                                                            .currentState
                                                            .validate()) {
                                                          Navigator.pop(
                                                              context);
                                                          await DatabaseService(
                                                                  uid: user.uid)
                                                              .UpdateUserData(
                                                                  _currentname ??
                                                                      userData
                                                                          .name,
                                                                  _phonenumber ??
                                                                      userData
                                                                          .phonenumber,
                                                                  _age ??
                                                                      userData
                                                                          .age);
                                                          setState(() {
                                                            Navigator.pop(
                                                                context);
                                                          });
                                                        }
                                                      }),
                                                ]),
                                              );
                                            },
                                          );
                                        });
                                      },
                                    ),
                                  ),
                                  Divider(
                                    indent: 70,
                                    height: 5,
                                  ),

                                  //Age Tile
                                  ListTile(
                                    leading: Icon(Icons.info_outline),
                                    title: Text(
                                      '${userData.age}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle:
                                        Text('What may your age be traveller?'),
                                    trailing: IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed: () {
                                        setState(() {
                                          showModalBottomSheet<void>(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Form(
                                                key: _formkey,
                                                child: Column(children: [
                                                  SizedBox(
                                                    height: 20.0,
                                                  ),
                                                  Text(
                                                    'Update Age',
                                                    style: TextStyle(
                                                      fontSize: 20.0,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 20.0,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            20.0, 0, 20.0, 0.0),
                                                    child: TextFormField(
                                                      inputFormatters: [
                                                        FilteringTextInputFormatter
                                                            .digitsOnly
                                                      ],
                                                      keyboardType:
                                                          TextInputType.number,
                                                      initialValue: userData.age
                                                          .toString(),
                                                      decoration:
                                                          textinput.copyWith(
                                                        hintText: 'Age',
                                                        hintStyle: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      validator: (val) => val
                                                                      .length ==
                                                                  0 ||
                                                              val.length > 3
                                                          ? 'Please enter an age between  0 - 130'
                                                          : null,
                                                      onChanged: (val) {
                                                        setState(() {
                                                          _age = int.parse(val);
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10.0,
                                                  ),
                                                  FlatButton(
                                                      color: Colors.pinkAccent,
                                                      child: Text('Update'),
                                                      onPressed: () async {
                                                        if (_formkey
                                                            .currentState
                                                            .validate()) {
                                                          Navigator.pop(
                                                              context);
                                                          await DatabaseService(
                                                                  uid: user.uid)
                                                              .UpdateUserData(
                                                                  _currentname ??
                                                                      userData
                                                                          .name,
                                                                  _phonenumber ??
                                                                      userData
                                                                          .phonenumber,
                                                                  _age ??
                                                                      userData
                                                                          .age);
                                                          setState(() {
                                                            Navigator.pop(
                                                                context);
                                                          });
                                                        }
                                                      }),
                                                ]),
                                              );
                                            },
                                          );
                                        });
                                      },
                                    ),
                                  ),
                                  Divider(
                                    indent: 70,
                                    height: 5,
                                  ),

                                  //tile for phone number
                                  ListTile(
                                    leading: Icon(Icons.call),
                                    title: Text(
                                      userData.phonenumber,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text('Phone Number'),
                                    trailing: IconButton(
                                        icon: Icon(Icons.edit),
                                        onPressed: () {
                                          setState(() {
                                            showModalBottomSheet<void>(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Form(
                                                  key: _formkey,
                                                  child: Column(children: [
                                                    SizedBox(
                                                      height: 20.0,
                                                    ),
                                                    Text(
                                                      'Update Phone Number',
                                                      style: TextStyle(
                                                        fontSize: 20.0,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 20.0,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              20.0,
                                                              0,
                                                              20.0,
                                                              0.0),
                                                      child: TextFormField(
                                                        inputFormatters: [
                                                          FilteringTextInputFormatter
                                                              .digitsOnly
                                                        ],
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        initialValue: userData
                                                            .phonenumber
                                                            .toString(),
                                                        decoration:
                                                            textinput.copyWith(
                                                          hintText: 'Phone No.',
                                                          hintStyle: TextStyle(
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                        validator: (val) => val
                                                                    .length >
                                                                11
                                                            ? 'Please enter a valid phone number'
                                                            : null,
                                                        onChanged: (val) {
                                                          setState(() {
                                                            _phonenumber = val;
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10.0,
                                                    ),
                                                    FlatButton(
                                                        color:
                                                            Colors.pinkAccent,
                                                        child: Text('Update'),
                                                        onPressed: () async {
                                                          if (_formkey
                                                              .currentState
                                                              .validate()) {
                                                            Navigator.pop(
                                                                context);
                                                            await DatabaseService(
                                                                    uid: user
                                                                        .uid)
                                                                .UpdateUserData(
                                                                    _currentname ??
                                                                        userData
                                                                            .name,
                                                                    _phonenumber ??
                                                                        userData
                                                                            .phonenumber,
                                                                    _age ??
                                                                        userData
                                                                            .age);
                                                            setState(() {
                                                              Navigator.pop(
                                                                  context);
                                                            });
                                                          }
                                                        }),
                                                  ]),
                                                );
                                              },
                                            );
                                          });
                                        }),
                                  ),
                                  Divider(
                                    indent: 70,
                                    height: 5,
                                  ),
                                  SizedBox(height: 20.0),
                                ]),
                              )
                            ],
                          ),
                        ],
                      );
                    } else {
                      return Container(
                        height: 0,
                        width: 0,
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
