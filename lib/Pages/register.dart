import 'package:flutter/material.dart';
import 'package:rapidkl/Services/Loading.dart';
import 'package:rapidkl/Services/textdecoration.dart';
import 'package:rapidkl/Services/services.dart';

class Register extends StatefulWidget {
  @override
  _registerState createState() => _registerState();
}

class _registerState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_rounded),
                color: Colors.blueGrey[800],
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              elevation: 0,
            ),
            backgroundColor: Colors.white,
            body: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: Form(
                  key: _formkey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // RapidKL logo
                        Image.asset(
                          'images/rapidkllogo.png',
                          height: 100,
                          width: 200,
                        ),

                        // Page title
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 15.0, bottom: 25),
                            child: Text(
                              'Create Account',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey[800]),
                            ),
                          ),
                        ),

                        // Email field
                        TextFormField(
                          decoration: const InputDecoration(
                            icon: Icon(Icons.person),
                            hintText: 'Email',
                            hintStyle: TextStyle(color: Colors.grey),
                            fillColor: Colors.white,
                          ),
                          validator: (val) =>
                              val.length < 11 ? "Enter an email" : null,
                          onChanged: (val) {
                            setState(() {
                              email = val;
                            });
                          },
                        ),

                        SizedBox(
                          height: 20.0,
                        ),

                        // Password field
                        TextFormField(
                          decoration: const InputDecoration(
                            icon: Icon(Icons.lock),
                            hintText: 'Password',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          validator: (val) => val.length < 8
                              ? "Enter a password 8 characters long"
                              : null,
                          obscureText: true,
                          onChanged: (val) {
                            setState(() {
                              password = val;
                            });
                          },
                        ),

                        SizedBox(
                          height: 50.0,
                        ),

                        // Register button
                        ButtonTheme(
                          height: 40,
                          minWidth: 220,
                          child: RaisedButton(
                              color: Colors.blueGrey[800],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0)),
                              child: Text('Register',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16)),
                              onPressed: () async {
                                if (_formkey.currentState.validate()) {
                                  setState(() {
                                    loading = true;
                                  });
                                  dynamic result =
                                      await _auth.signinemp(email, password);
                                  if (result == null) {
                                    setState(() {
                                      loading = false;
                                      error =
                                          'The email or password is invalid';
                                    });
                                  } else {
                                    Navigator.pop(context);
                                  }
                                }
                              }),
                        ),

                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          error,
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                )));
  }
}
