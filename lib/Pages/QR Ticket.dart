import 'package:flutter/material.dart';
import 'package:rapidkl/Pages/Home.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:intl/intl.dart';

class QRTicket extends StatefulWidget {

  String location;
  String destination;
  double price;
  int count = 0;
  bool checkBoxValue;

  QRTicket({this.location, this.destination, this.price, this.count , this.checkBoxValue});


  @override
  _QRTicketState createState() => _QRTicketState(location, destination, count , checkBoxValue);
}


class _QRTicketState extends State<QRTicket> {

  String location;
  String destination;
  double price;
  int count = 0;
  bool checkBoxValue;
  String trip;

  _QRTicketState(this.location, this.destination, this.count , this.checkBoxValue);




  @override
  Widget build(BuildContext context) {

    final DateTime now = DateTime.now().add(Duration(days: 1));
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    final String formatteddate = formatter.format(now);


    if (checkBoxValue == true){
      trip = 'Round Trip';
    }
    else {
      trip = 'One Way';
    };

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded),
          color: Colors.blueGrey[800],
          onPressed: () {
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/myapp', ModalRoute.withName('/myapp'));
          },
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Page title
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(
                'Your Ticket',
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
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
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

                  // Valid and ticket type
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Valid Until',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                          Text(
                            formatteddate,
                            style: TextStyle(
                                fontSize: 22,
                                color: Colors.red,
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
            )),
          ),

          SizedBox(height: 20),

          // QR Ticket
          QrImage(
            data: "new ticket",
            version: QrVersions.auto,
            size: 200.0,
          ),

          // Checkout button
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(top: 30.0),
              child: ButtonTheme(
                height: 50,
                minWidth: 250.0,
                child: FlatButton.icon(
                  icon: Icon(
                    Icons.share,
                    size: 20,
                    color: Colors.blueGrey[800],
                  ),
                  label: Text(
                    'Share',
                    style: TextStyle(color: Colors.blueGrey[800], fontSize: 18),
                  ),
                  onPressed: () {},
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
