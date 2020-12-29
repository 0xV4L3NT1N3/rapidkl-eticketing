import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[300],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // RapidKL logo
          Padding(
            padding: const EdgeInsets.only(top: 150.0),
            child: Image.asset(
              'images/rapidkllogo.png',
              height: 100,
              width: 200,
            ),
          ),

          // Spinning dots
          SpinKitDoubleBounce(
            color: Colors.white,
            size: 70.0,
            duration: Duration(seconds: 2),
          ),

          SizedBox(height: 20),

          // Loading text
          Text(
            'Initializing...',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 30.0,
            ),
          )
        ],
      ),
    );
  }
}
