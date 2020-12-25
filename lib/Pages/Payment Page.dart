import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

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

            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Column(
                children: [
                  Card(
                    child: ListTile(
                      leading: Icon(
                        FontAwesome.bank,
                        color: Colors.blueAccent,
                      ),
                      title: Text('Online Banking'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: Icon(
                        FontAwesome.credit_card,
                        color: Colors.redAccent,
                      ),
                      title: Text('Credit/Debit Card'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: Icon(FontAwesome.bitcoin, color: Colors.orange),
                      title: Text('Bitcoin'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: Icon(
                        FontAwesome.money,
                        color: Colors.green,
                      ),
                      title: Text('Cash at Counter'),
                    ),
                  ),
                ],
              ),
            ),

            // Checkout button
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 30.0),
                child: ButtonTheme(
                  height: 50,
                  minWidth: 250.0,
                  child: RaisedButton(
                    elevation: 20,
                    color: Colors.blueGrey[800],
                    child: Text(
                      'Complete Payment ',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    onPressed: () {
                      Navigator.popAndPushNamed(context, '/qrticket');
                    },
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
