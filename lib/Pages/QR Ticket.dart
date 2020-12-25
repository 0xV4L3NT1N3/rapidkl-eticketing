import 'package:flutter/material.dart';
import 'package:rapidkl/Pages/Home.dart';


class QRTicket extends StatefulWidget {
  @override
  _QRTicketState createState() => _QRTicketState();
}

class _QRTicketState extends State<QRTicket> {

  int count;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Text(
                'Here You Go!',
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey[800]),
              ),
            ),
          ),
          SizedBox(height: 100.0,),
          Text('QRTICKET GOES HERE', style: TextStyle(fontSize: 20.0),),
          SizedBox(height: 300.0,),
          SingleChildScrollView(
            child: Container(
              height: 100.0,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: 170.0,
                  height: 40.0,
                  child: ButtonTheme(
                    child: RaisedButton(
                      child: Row(
                        children: [
                          Text('Return To Home'),
                          Icon(Icons.home_outlined),
                        ],
                      ),
                      onPressed: (){
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (c) => MyApp()),
                                (route) => false);
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
