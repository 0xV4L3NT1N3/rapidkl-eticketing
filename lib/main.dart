import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rapidkl/Pages/Home.dart';
import 'package:rapidkl/Services/services.dart';
import 'package:rapidkl/Services/wrapper.dart';
import 'package:rapidkl/Services/User.dart';
import 'package:rapidkl/Pages/signin.dart';
import 'package:rapidkl/Pages/register.dart';
import 'package:rapidkl/Pages/Confirmation Page.dart';
import 'package:rapidkl/Pages/Payment Page.dart';
import 'package:rapidkl/Pages/QR Ticket.dart';
import 'package:rapidkl/Pages/ResetPassword.dart';

void main() {
  ErrorWidget.builder = (FlutterErrorDetails details) => Container();
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
        theme: ThemeData(
            primarySwatch: Colors.blueGrey, primaryColor: Colors.blueGrey[800]),
        routes: {
          '/': (context) => Wrapper(),
          '/home': (context) => Home(),
          '/signin': (context) => SignIn(),
          '/register': (context) => Register(),
          '/confirmation': (context) => Confirmation(),
          '/payment': (context) => Payment(),
          '/qrticket': (context) => QRTicket(),
          '/myapp': (context) => MyApp(),
          '/resetpassword': (context) => ResetPassword(),
        },
      ),
    );
  }
}
