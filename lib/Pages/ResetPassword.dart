import 'package:flutter/material.dart';
import 'package:rapidkl/Services/services.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();

  String email = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
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
                        padding: const EdgeInsets.only(left: 15.0, bottom: 25),
                        child: Text(
                          'Reset Password',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey[800]),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 20.0,
                    ),

                    // Reset email field
                    TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.email_rounded),
                        hintText: 'Enter your recovery email',
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

                    // Reset password button
                    ButtonTheme(
                      height: 40,
                      minWidth: 220,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0)),
                      child: RaisedButton(
                          color: Colors.blueGrey[800],
                          child: Text('Reset Password',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16)),
                          onPressed: () async {
                            if (_formkey.currentState.validate()) {
                              Navigator.pop(context);
                              await _auth.sendpasswordresetemail(email);
                            }
                          }),
                    ),
                  ],
                ),
              ),
            )));
  }
}
