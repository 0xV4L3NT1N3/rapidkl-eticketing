import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rapidkl/Pages/signin.dart';

class Payment extends StatefulWidget {
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
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
        height: double.maxFinite,
        width: double.maxFinite,
        child: Column(
          children: [
            // Page title
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  'Payment',
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[800]),
                ),
              ),
            ),

            SizedBox(height: 20),
            Card(
              child: ListTile(
                leading: FlutterLogo(),
                title: Text('Visa Card'),
              ),
            ),

            SingleChildScrollView(
              child: Container(
                height: 300.0,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 120.0,
                        height: 40.0,
                        child: ButtonTheme(
                          child: RaisedButton(
                            child: Row(
                              children: [
                                Text('Pay NOW'),
                                Icon(Icons.check_circle_outline),
                              ],
                            ),
                            onPressed: () {
                              Navigator.popAndPushNamed(context, '/qrticket');
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 70.0),
                        child: SizedBox(
                          width: 120.0,
                          height: 40.0,
                          child: ButtonTheme(
                            child: RaisedButton(
                              child: Row(
                                children: [
                                  Text('Cancel'),
                                  Icon(Icons.cancel_outlined),
                                ],
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
