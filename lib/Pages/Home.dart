import 'package:flutter/material.dart';
import 'package:rapidkl/Pages/News.dart';
import 'package:rapidkl/Pages/Profile.dart';


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
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('hello'),
    );
  }
}


