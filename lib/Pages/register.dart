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
    return loading ? Loading() : Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: Text('Register'),
          elevation: 0.0,
        ),
        body: Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            child: Form(
              key: _formkey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      decoration: textinput.copyWith(hintText: 'Email', hintStyle: TextStyle(color : Colors.white), ),
                      validator: (val) =>  val.length < 11? "Enter an email" : null,
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      decoration: textinput.copyWith(hintText: 'Password', hintStyle: TextStyle(color : Colors.white),),
                      validator: (val) => val.length < 8 ? "Enter a password 8 characters long" : null,
                      obscureText: true,
                      onChanged: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    RaisedButton(
                        child: Text('Register'),
                        onPressed: (
                            ) async {
                          if (_formkey.currentState.validate()){
                            dynamic result = await _auth.signinemp(email, password);
                            if(result == null){
                              setState(() {
                                error = 'The email or password is invalid';
                              });
                            }
                            else {
                              setState(() {
                                loading = true;
                              }
                              );
                              Navigator.pop(context);
                            }
                          }
                        }
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
            )
        )
    );
  }
}
