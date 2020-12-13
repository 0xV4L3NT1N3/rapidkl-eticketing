import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SpinKitChasingDots(
              color: Colors.grey,
              size: 70.0,
              duration: Duration(seconds: 3),
            ),
          ),
          Text(
            'Loading...', style: TextStyle(
            color: Colors.white70,
            fontSize: 30.0,
          ),
          )
        ],
      ),
    );
  }
}