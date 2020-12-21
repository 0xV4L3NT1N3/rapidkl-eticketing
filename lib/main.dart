import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rapidkl/Services/services.dart';
import 'package:rapidkl/Services/wrapper.dart';
import 'package:rapidkl/Services/User.dart';
import 'package:rapidkl/Pages/signin.dart';
import 'package:rapidkl/Pages/register.dart';

<<<<<<< Updated upstream


void main(){
=======
void main() {
>>>>>>> Stashed changes
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => Wrapper(),
          '/signin': (context) => SignIn(),
          '/register': (context) => Register(),
        },
      ),
    );
  }
}
