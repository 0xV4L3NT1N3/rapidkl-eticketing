import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rapidkl/Services/Price counter.dart';

class Confirmation extends StatefulWidget {
  String location;
  String destination;
  double price;

  Confirmation({this.location, this.destination, this.price});

  @override
  _ConfirmationState createState() =>
      _ConfirmationState(location, destination, price);
}

class _ConfirmationState extends State<Confirmation> {
  String location;
  String destination;
  int count = 1;
  double price;
  _ConfirmationState(this.location, this.destination, this.price);

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Page title
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  'Confirm Booking',
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[800]),
                ),
              ),
            ),

            SizedBox(
              height: 30.0,
            ),
            SizedBox(
              height: 300.0,
              width: 300.0,
              child: Card(
                elevation: 5.0,
                color: Colors.white70,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Location : ${location}',
                            style: TextStyle(fontSize: 14.0),
                          )),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Destination : ${destination}',
                              style: TextStyle(fontSize: 14.0))),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Text('Number of Tickets : ${count}',
                                  style: TextStyle(fontSize: 14.0)),
                              SizedBox(width: 30.0),
                              IconButton(
                                  icon: Icon(Icons.expand_less),
                                  splashRadius: 20.0,
                                  onPressed: () {
                                    setState(() {
                                      count = count + 1;
                                    });
                                  }),
                              IconButton(
                                  icon: Icon(Icons.expand_more),
                                  splashRadius: 20.0,
                                  onPressed: () {
                                    setState(() {
                                      if (count == 0) {
                                        count = 0;
                                      } else {
                                        count = count - 1;
                                      }
                                    });
                                  })
                            ],
                          )),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                              'Total Price : RM${(price * count).toStringAsFixed(2)}',
                              style: TextStyle(fontSize: 14.0))),
                    ),
                  ],
                ),
              ),
            ),
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
                      'Checkout ',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/payment');
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
