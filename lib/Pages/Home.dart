import 'package:flutter/material.dart';
import 'package:rapidkl/Pages/News.dart';
import 'package:rapidkl/Pages/Profile.dart';
import 'package:rapidkl/Pages/Confirmation Page.dart';
import 'package:rapidkl/Services/Price counter.dart';



class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override

  int currentIndex = 0;
  PageController _pageController = PageController();



  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.blue,
          currentIndex: currentIndex,
          onTap: (value) {
            currentIndex = value;
            _pageController.jumpToPage(value);
          },
          items: [
            BottomNavigationBarItem(
                icon:Icon(Icons.house),
                label : 'Home'),
            BottomNavigationBarItem(
                icon:Icon(Icons.article_outlined),
                label : 'News'),
            BottomNavigationBarItem(
                icon:Icon(Icons.person_rounded),
                label : 'Profile'),
          ]),

      body: PageView(
        controller: _pageController,
        onPageChanged: (value){
          setState(() {
            currentIndex = value;
          });
        },
        children: [
          Home(),
          News(),
          Profile(),
        ],
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String location;
  String destination;
  String errortext ='';
  double price;
  var _controller = TextEditingController();
  var _controller1 = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Page title
            Padding(
              padding: const EdgeInsets.only(top: 30.0, left: 15.0),
              child: Text(
                'Book a Ticket',
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey[800]),
              ),
            ),
            // Location/destination card
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12.0),
              child: Container(
                child: Card(
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.assistant_photo),
                                border: InputBorder.none,
                                hintText: 'Your location',
                                suffixIcon: IconButton(
                                onPressed: () => _controller.clear(),
                                icon: Icon(Icons.clear),
                              ),
                            ),
                            onChanged: (text){
                              location = text;
                            },
                          ),
                          Divider(),
                          TextField(
                            controller: _controller1,
                            autofocus: true,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.location_on_rounded),
                                border: InputBorder.none,
                                hintText: 'Destination station',
                                suffixIcon: IconButton(
                                onPressed: () => _controller1.clear(),
                                icon: Icon(Icons.clear),
                              ),
                            ),

                            onChanged: (text){
                              destination = text;
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                  padding: EdgeInsets.only(top: 410.0),
                  child: SizedBox(
                    width: 107.0,
                    height: 40.0,
                      child: RaisedButton(
                        child: Row(
                          children: [
                            Text('Confirm'),
                            Icon(Icons.add_shopping_cart),
                          ],
                        ),
                        onPressed: (){
                          if( location != null && destination != null && location != '' && destination != '' ){
                            setState(() {
                              errortext = '';
                              price = PriceChecker().PriceConfirm(destination);
                              _controller.clear();
                              _controller1.clear();
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Confirmation( location : location , destination: destination , price : price))).whenComplete(() {
                                setState(() {
                                  location = null;
                                  destination = null;
                                });
                              });
                            });
                          }
                          else{
                            setState(() {
                              errortext = 'Please Select a Location and Destination';
                            });
                          }
                        },
                      ),
                  ),
                  ),
            ),
            SizedBox(height: 10.0,),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text( errortext, style: TextStyle(fontSize: 11, color: Colors.red),),
            )
          ],
        ),
      ),
    );
  }
}


