import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rapidkl/Pages/Payment Page.dart';

class Confirmation extends StatefulWidget {
  String location;
  String destination;
  double price;
  int count = 0;
  bool checkBoxValue;

  Confirmation(
      {this.location,
      this.destination,
      this.price,
      this.count,
      this.checkBoxValue});

  @override
  _ConfirmationState createState() =>
      _ConfirmationState(location, destination, price, count, checkBoxValue);
}

class _ConfirmationState extends State<Confirmation> {
  String location;
  String destination;
  double price;
  int count;
  bool checkBoxValue;
  String trip;

  _ConfirmationState(this.location, this.destination, this.price, this.count,
      this.checkBoxValue);

  @override
  Widget build(BuildContext context) {
    if (checkBoxValue == true) {
      trip = 'Round Trip';
    } else {
      trip = 'One Way';
    }

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

            SizedBox(height: 20),

            // Ticket details card
            Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12.0),
              child: Container(
                  child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Start location
                          Column(
                            children: [
                              Text('MRT',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey[600])),
                              Container(
                                width: 120,
                                child: Text(
                                  location,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.blueGrey[800],
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          // Arrow icon
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.blueGrey[800],
                            size: 30,
                          ),
                          // End destination
                          Column(
                            children: [
                              Text('MRT',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey[600])),
                              Container(
                                width: 120,
                                child: Text(
                                  destination,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.blueGrey[800],
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 25),
                      // Quantity details
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Quantity',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                              Text(
                                '$count',
                                style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.blueGrey[800],
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          // Ticket type details
                          Column(
                            children: [
                              Text(
                                'Ticket Type',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                              Text(
                                trip,
                                style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.blueGrey[800],
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )),
            ),

            // Total card
            Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12.0),
              child: Container(
                  child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey[800],
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'RM${(price * count).toStringAsFixed(2)}',
                        style: TextStyle(
                            fontSize: 28,
                            color: Colors.red,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              )),
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
                      'Checkout ',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Payment(
                                location: location,
                                destination: destination,
                                price: price,
                                count: count,
                                checkBoxValue: checkBoxValue,
                              )));
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
