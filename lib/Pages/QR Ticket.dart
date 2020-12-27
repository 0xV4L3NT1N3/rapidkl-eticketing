import 'package:flutter/material.dart';
import 'package:rapidkl/Pages/Home.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRTicket extends StatefulWidget {
  @override
  _QRTicketState createState() => _QRTicketState();
}

class _QRTicketState extends State<QRTicket> {
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

          SizedBox(height: 10),

          // Ticket details card
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Container(
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
                              'Semantan',
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
                              'Maluri',
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
                            '28/12/2020',
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
                            ' Round Trip',
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
