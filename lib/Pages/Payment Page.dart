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
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Text(
                  'Payment',
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[800]),
                ),
              ),
            ),
            SizedBox(height: 30.0,),
            Align(
              alignment: Alignment.center,
              child: Icon(Icons.credit_card_outlined, size: 50.0,),
            ),
            SizedBox(height: 20.0,),
            Text('You Will Be Redirected To Your Payment Option ', style: TextStyle(fontSize: 14.0),),
            AspectRatio(
              aspectRatio: 2/2.5,
              child: Container(
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
                                onPressed: (){
                                  Navigator.popAndPushNamed(context, '/qrticket');
                                },
                              ),
                            ),
                          ),
                      Padding(
                        padding: EdgeInsets.only( left: 70.0),
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
                              onPressed: (){
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
