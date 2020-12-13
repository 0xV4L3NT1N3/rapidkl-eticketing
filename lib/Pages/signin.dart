import 'package:flutter/material.dart';
import 'file:///C:/Users/timot/Documents/GitHub/rapidklmobileapp/lib/Services/Loading.dart';
import 'package:rapidkl/Services/services.dart';
import 'file:///C:/Users/timot/Documents/GitHub/rapidklmobileapp/lib/Services/textdecoration.dart';


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
    return loading ? Loading(): Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('Sign In'),
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
                  decoration: textinput.copyWith(hintText: 'Email', hintStyle: TextStyle(color : Colors.white),),
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
                Text(
                    error, style: TextStyle(color: Colors.red),
                ),
                RaisedButton(
                    child: Text('Sign In'),
                    onPressed: (
                    ) async {
                      if (_formkey.currentState.validate()) {
                        setState(() {
                          loading = true;
                        });
                        dynamic result = await _auth.signin(email, password);
                        if (result == null) {
                          setState(() {
                            error = 'The email or password is invalid';
                            loading = false;
                          });
                        }
                      }
                    }),
                SizedBox(
                  height: 20.0,
                ),
                RaisedButton(
                    child: Text('Register New User'),
                    onPressed: (
                        )  {
                      Navigator.pushNamed(context, '/register');
                    }
                ),

              ],
            ),
          ),
        )
      )
    );
  }
}
