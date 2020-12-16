import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:rapidkl/Services/User.dart';
import 'package:rapidkl/Services/services.dart';
import 'package:rapidkl/Services/database.dart';
import 'package:provider/provider.dart';
import 'package:rapidkl/Services/Loading.dart';
import 'package:rapidkl/Services/textdecoration.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Profile extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<Profile> {
  File _image;

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

  //options for camera and gallery
  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
              height: 200.0,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(20.0, 50.0, 30.0, 15.0),
                          child: IconButton(
                              icon: Icon(
                                  Icons.camera_alt,
                                  size: 60.0,
                                ),
                              onPressed: () {
                                _imgFromCamera();
                              }),
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 13.0),
                            child: Text('Take Picture')),
                      ]),
                      Column(children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(30.0, 50.0, 20.0, 15.0),
                          child: IconButton(
                              icon: Icon(
                                Icons.photo,
                                size: 60.0,
                              ),
                              onPressed: () {
                                _imgFromGallery();
                              }),
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 40.0),
                            child: Text('Pick Image from Gallery')),
                      ]),
                    ],
                  ),
                ],
              ));
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

  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return SingleChildScrollView(
      child: Container(
        height: 700,
        width: 1000,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Profile'),
          ),
          body: Column(
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
              GestureDetector(
                onTap: () {
                  _showPicker(context);
                },
                child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 80,
                    child: _image != null
                        ? ClipOval(
                        child: Image.file(_image,
                        width: 1000,
                        height: 1000,
                        fit: BoxFit.cover,),
                    )
                        : CircleAvatar(
                            radius: 80,
                            backgroundImage: AssetImage(
                                'images/blank-profile-picture-973460_640.png'),
                          )),
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
                                      style: TextStyle(fontWeight: FontWeight.bold),
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
                                                    padding: EdgeInsets.fromLTRB(
                                                        20.0, 0, 20.0, 0.0),
                                                    child: TextFormField(
                                                      initialValue: userData.name,
                                                      decoration:
                                                          textinput.copyWith(
                                                        hintText: 'Name',
                                                        hintStyle: TextStyle(
                                                            color: Colors.black),
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
                                                        if (_formkey.currentState
                                                            .validate()) {
                                                          await DatabaseService(
                                                                  uid: user.uid)
                                                              .UpdateUserData(
                                                                  _currentname ??
                                                                      userData.name,
                                                                  _phonenumber ??
                                                                      userData
                                                                          .phonenumber,
                                                                  _age ??
                                                                      userData.age);
                                                          setState(() {
                                                            Navigator.pop(context);
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
                                      style: TextStyle(fontWeight: FontWeight.bold),
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
                                                    padding: EdgeInsets.fromLTRB(
                                                        20.0, 0, 20.0, 0.0),
                                                    child: TextFormField(
                                                      inputFormatters: [
                                                        FilteringTextInputFormatter
                                                            .digitsOnly
                                                      ],
                                                      keyboardType:
                                                          TextInputType.number,
                                                      initialValue:
                                                          userData.age.toString(),
                                                      decoration:
                                                          textinput.copyWith(
                                                        hintText: 'Age',
                                                        hintStyle: TextStyle(
                                                            color: Colors.black),
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
                                                        if (_formkey.currentState
                                                            .validate()) {
                                                          await DatabaseService(
                                                                  uid: user.uid)
                                                              .UpdateUserData(
                                                                  _currentname ??
                                                                      userData.name,
                                                                  _phonenumber ??
                                                                      userData
                                                                          .phonenumber,
                                                                  _age ??
                                                                      userData.age);
                                                          setState(() {
                                                            Navigator.pop(context);
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
                                    title: Text( userData.phonenumber,
                                      style: TextStyle(fontWeight: FontWeight.bold),
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
                                                      padding: EdgeInsets.fromLTRB(
                                                          20.0, 0, 20.0, 0.0),
                                                      child: TextFormField(
                                                        inputFormatters: [
                                                          FilteringTextInputFormatter
                                                              .digitsOnly
                                                        ],
                                                        keyboardType:
                                                            TextInputType.number,
                                                        initialValue: userData
                                                            .phonenumber
                                                            .toString(),
                                                        decoration:
                                                            textinput.copyWith(
                                                          hintText: 'Phone No.',
                                                          hintStyle: TextStyle(
                                                              color: Colors.black),
                                                        ),
                                                        validator: (val) => val.length > 11
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
                                                        color: Colors.pinkAccent,
                                                        child: Text('Update'),
                                                        onPressed: () async {
                                                          if (_formkey.currentState
                                                              .validate()) {
                                                            await DatabaseService(
                                                                    uid: user.uid)
                                                                .UpdateUserData(
                                                              _currentname ??
                                                                  userData.name,
                                                              _phonenumber ?? userData.phonenumber,
                                                              _age ??
                                                                  userData
                                                                      .age,
                                                            );
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
