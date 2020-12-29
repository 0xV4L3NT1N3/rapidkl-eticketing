import 'package:flutter/material.dart';
import 'package:rapidkl/Services/Loading.dart';
import 'package:rapidkl/Services/services.dart';
import 'package:rapidkl/Services/textdecoration.dart';

class SignIn extends StatefulWidget {
  @override
  _signInState createState() => _signInState();
}

class _signInState extends State<SignIn> {
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
            backgroundColor: Colors.white,
            body: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: Form(
                  key: _formkey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // RapidKL logo
                        Padding(
                          padding: const EdgeInsets.only(top: 50.0),
                          child: Image.asset(
                            'images/rapidkllogo.png',
                            height: 100,
                            width: 200,
                          ),
                        ),

                        SizedBox(
                          height: 20.0,
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
                          height: 30.0,
                        ),
                        Text(
                          error,
                          style: TextStyle(color: Colors.red),
                        ),

                        // Sign In button
                        ButtonTheme(
                          height: 40,
                          minWidth: 220,
                          child: RaisedButton(
                              color: Colors.blueGrey[800],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0)),
                              child: Text('Sign In',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16)),
                              onPressed: () async {
                                if (_formkey.currentState.validate()) {
                                  setState(() {
                                    loading = true;
                                  });
                                  dynamic result =
                                      await _auth.signin(email, password);
                                  if (result == null) {
                                    setState(() {
                                      error =
                                          'The email or password is invalid';
                                      loading = false;
                                    });
                                  }
                                }
                              }),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),

                        // Register New User button
                        ButtonTheme(
                          height: 40,
                          minWidth: 220,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0)),
                          child: RaisedButton(
                              color: Colors.blueGrey[800],
                              child: Text('Register New User',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16)),
                              onPressed: () {
                                Navigator.pushNamed(context, '/register');
                              }),
                        ),

                        SizedBox(
                          height: 20.0,
                        ),

                        // Reset password text
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Forgot Password ? '),
                            GestureDetector(
                              child: Text(
                                'Click here.',
                                style: TextStyle(
                                    decoration: TextDecoration.underline),
                              ),
                              onTap: () {
                                Navigator.pushNamed(context, '/resetpassword');
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )));
  }
}
