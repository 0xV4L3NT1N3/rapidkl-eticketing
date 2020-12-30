import 'package:flutter/material.dart';
import 'package:rapidkl/Pages/News.dart';
import 'package:rapidkl/Pages/Profile.dart';
import 'package:rapidkl/Pages/Confirmation Page.dart';
import 'package:rapidkl/Services/Price counter.dart';
import 'package:rapidkl/Pages/Tickets.dart';
import 'package:rapidkl/Services/database.dart';
import 'package:rapidkl/Services/User.dart';
import 'package:provider/provider.dart';
import 'package:rapidkl/Services/textdecoration.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:rapidkl/Services/suggestions.dart';

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
          selectedItemColor: Colors.red[600],
          unselectedItemColor: Colors.blueGrey[800],
          currentIndex: currentIndex,
          onTap: (value) {
            currentIndex = value;
            _pageController.jumpToPage(value);
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.house), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.toll), label: 'Tickets'),
            BottomNavigationBarItem(
                icon: Icon(Icons.article_outlined), label: 'News'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_rounded), label: 'Profile'),
          ]),
      body: PageView(
        controller: _pageController,
        onPageChanged: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        children: [
          Home(),
          Tickets(),
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
  String newlocation;
  String newdestionation;

  String location;
  String destination;
  String ticketstatus;
  int count = 1;
  String errortext = '';
  double price;
  bool checkBoxValue = false;
  var _controller = TextEditingController();
  var _controller1 = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          height: 700.0,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Page title
                Padding(
                  padding: const EdgeInsets.only(top: 50.0, left: 20.0),
                  child: Text(
                    'Book a Ticket',
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey[800]),
                  ),
                ),

                // Location & destination card
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
                              TypeAheadField(
                                  textFieldConfiguration:
                                      TextFieldConfiguration(
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.assistant_photo,
                                        color: Colors.lightBlue[700],
                                      ),
                                      border: InputBorder.none,
                                      hintText: 'Your location',
                                      suffixIcon: IconButton(
                                        onPressed: () => _controller.clear(),
                                        icon: Icon(Icons.clear),
                                      ),
                                    ),
                                    onChanged: (text) {
                                      location = text;
                                    },
                                    controller: _controller,
                                  ),
                                  suggestionsCallback: (pattern) async {
                                    return Stations.getSuggestions(pattern);
                                  },
                                  itemBuilder: (context, suggestion) {
                                    return ListTile(
                                      title: Text(suggestion),
                                    );
                                  },
                                  onSuggestionSelected: (suggestion) {
                                    location = suggestion;
                                    _controller.text = suggestion;
                                  }),
                              Divider(),
                              TypeAheadField(
                                  textFieldConfiguration:
                                      TextFieldConfiguration(
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.location_on_rounded,
                                        color: Colors.red,
                                      ),
                                      border: InputBorder.none,
                                      hintText: 'Destination station',
                                      suffixIcon: IconButton(
                                        onPressed: () => _controller1.clear(),
                                        icon: Icon(Icons.clear),
                                      ),
                                    ),
                                    onChanged: (text) {
                                      destination = text;
                                    },
                                    controller: _controller1,
                                  ),
                                  suggestionsCallback: (pattern) async {
                                    return Stations.getSuggestions(pattern);
                                  },
                                  transitionBuilder:
                                      (context, suggestionsBox, controller) {
                                    return suggestionsBox;
                                  },
                                  itemBuilder: (context, suggestion) {
                                    return ListTile(
                                      title: Text(suggestion),
                                    );
                                  },
                                  onSuggestionSelected: (suggestion) {
                                    destination = suggestion;
                                    _controller1.text = suggestion;
                                  }),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Quantity and round trip card
                Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                  child: Container(
                      child: Card(
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'Ticket Quantity',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey[600]),
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      IconButton(
                                          icon: Icon(Icons.expand_less),
                                          splashRadius: 20.0,
                                          onPressed: () {
                                            setState(() {
                                              if (count == 99) {
                                                count = 99;
                                              } else {
                                                count = count + 1;
                                              }
                                            });
                                          }),
                                      Text(
                                        count.toString(),
                                        style: TextStyle(
                                            fontSize: 28,
                                            color: Colors.blueGrey[800],
                                            fontWeight: FontWeight.bold),
                                      ),
                                      IconButton(
                                          icon: Icon(Icons.expand_more),
                                          splashRadius: 20.0,
                                          onPressed: () {
                                            setState(() {
                                              if (count == 1) {
                                                count = 1;
                                              } else {
                                                count = count - 1;
                                              }
                                            });
                                          })
                                    ],
                                  )
                                ],
                              ),

                              SizedBox(width: 30),

                              // Round trip option
                              Checkbox(
                                  value: checkBoxValue,
                                  activeColor: Colors.red,
                                  onChanged: (bool newValue) {
                                    setState(() {
                                      checkBoxValue = newValue;
                                      print(checkBoxValue);
                                    });
                                    Text('Remember me');
                                  }),
                              Text(
                                'Round Trip',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey[600]),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Tooltip(
                                  message:
                                      'Round trip tickets are valid to/fro',
                                  child: Icon(
                                    Icons.info_outline_rounded,
                                    color: Colors.grey,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
                ),

                // Favourites text
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 15.0),
                  child: Text(
                    'Favourites',
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey[800]),
                  ),
                ),

                //Favourites block
                StreamBuilder<UserData>(
                    stream: DatabaseService(uid: user.uid).userData,
                    // ignore: missing_return
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return StreamBuilder<Favfunc>(
                            stream: DatabaseService(uid: user.uid).favourites,
                            // ignore: missing_return
                            builder: (context, snapshot) {
                              Favfunc favs = snapshot.data;
                              if (snapshot.hasData) {
                                List key = favs.keyarr;
                                List val = favs.valarr;
                                return Container(
                                  height: 70,
                                  width: double.maxFinite,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: key.length,
                                      // ignore: missing_return
                                      itemBuilder: (context, index) {
                                        //Home Card
                                        if (index == 0) {
                                          return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                destination = val[index];
                                                _controller1.text = val[index];
                                              });
                                            },
                                            child: Container(
                                              height: 60,
                                              width: 220,
                                              child: Card(
                                                child: ListTile(
                                                  leading: Icon(
                                                    Icons.home,
                                                    size: 25,
                                                    color: Colors.blueGrey[800],
                                                  ),
                                                  title: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8.0),
                                                    child: Text(key[index]),
                                                  ),
                                                  subtitle: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 13.0),
                                                    child: Text(val[index]),
                                                  ),
                                                  trailing: Transform.translate(
                                                      offset: Offset(-20, 0),
                                                      child: IconButton(
                                                          splashRadius: 20.0,
                                                          iconSize: 20.0,
                                                          icon:
                                                              Icon(Icons.edit),
                                                          onPressed: () {
                                                            setState(() {
                                                              showModalBottomSheet<
                                                                  void>(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  return Container(
                                                                    height:
                                                                        250.0,
                                                                    child: Form(
                                                                      key:
                                                                          _formkey,
                                                                      child: Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceEvenly,
                                                                          children: [
                                                                            Text(
                                                                              'Update Home',
                                                                              style: TextStyle(
                                                                                color: Colors.blueGrey[800],
                                                                                fontSize: 20.0,
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0.0),
                                                                              child: TextFormField(
                                                                                initialValue: val[index],
                                                                                decoration: const InputDecoration(
                                                                                  hintText: 'Home',
                                                                                  hintStyle: TextStyle(color: Colors.black),
                                                                                ),
                                                                                validator: (value) => value.length == 0 ? "Please enter a valid destination" : null,
                                                                                onChanged: (value) {
                                                                                  setState(() {
                                                                                    val[index] = value;
                                                                                  });
                                                                                },
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 10.0,
                                                                            ),
                                                                            ButtonTheme(
                                                                              height: 40,
                                                                              minWidth: 220,
                                                                              child: RaisedButton(
                                                                                  color: Colors.blueGrey[800],
                                                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
                                                                                  child: Text('Update', style: TextStyle(color: Colors.white, fontSize: 16)),
                                                                                  onPressed: () async {
                                                                                    if (_formkey.currentState.validate()) {
                                                                                      Navigator.pop(context);
                                                                                      await DatabaseService(uid: user.uid).UpdateFavourites(key, val);
                                                                                    }
                                                                                  }),
                                                                            ),
                                                                          ]),
                                                                    ),
                                                                  );
                                                                },
                                                              );
                                                            });
                                                          })),
                                                ),
                                              ),
                                            ),
                                          );
                                        }

                                        //Work Card
                                        else if (index == 1) {
                                          return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                destination = val[index];
                                                _controller1.text = val[index];
                                              });
                                            },
                                            child: Container(
                                              height: 60,
                                              width: 220,
                                              child: Card(
                                                child: ListTile(
                                                  leading: Icon(
                                                    Icons.work,
                                                    size: 25,
                                                    color: Colors.blueGrey[800],
                                                  ),
                                                  title: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8.0),
                                                    child: Text(key[index]),
                                                  ),
                                                  subtitle: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 13.0),
                                                    child: Text(val[index]),
                                                  ),
                                                  trailing: Transform.translate(
                                                      offset: Offset(-20, 0),
                                                      child: IconButton(
                                                          splashRadius: 20.0,
                                                          iconSize: 20.0,
                                                          icon:
                                                              Icon(Icons.edit),
                                                          onPressed: () {
                                                            setState(() {
                                                              showModalBottomSheet<
                                                                  void>(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  return Container(
                                                                    height:
                                                                        250.0,
                                                                    child: Form(
                                                                      key:
                                                                          _formkey,
                                                                      child: Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceEvenly,
                                                                          children: [
                                                                            Text(
                                                                              'Update Work',
                                                                              style: TextStyle(
                                                                                color: Colors.blueGrey[800],
                                                                                fontSize: 20.0,
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0.0),
                                                                              child: TextFormField(
                                                                                initialValue: val[index],
                                                                                decoration: const InputDecoration(
                                                                                  hintText: 'Work',
                                                                                  hintStyle: TextStyle(color: Colors.black),
                                                                                ),
                                                                                validator: (value) => value.length == 0 ? "Please enter a valid destination" : null,
                                                                                onChanged: (value) {
                                                                                  setState(() {
                                                                                    val[index] = value;
                                                                                  });
                                                                                },
                                                                              ),
                                                                            ),
                                                                            ButtonTheme(
                                                                              height: 40,
                                                                              minWidth: 220,
                                                                              child: RaisedButton(
                                                                                  color: Colors.blueGrey[800],
                                                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
                                                                                  child: Text('Update', style: TextStyle(color: Colors.white, fontSize: 16)),
                                                                                  onPressed: () async {
                                                                                    if (_formkey.currentState.validate()) {
                                                                                      Navigator.pop(context);
                                                                                      await DatabaseService(uid: user.uid).UpdateFavourites(key, val);
                                                                                    }
                                                                                  }),
                                                                            ),
                                                                          ]),
                                                                    ),
                                                                  );
                                                                },
                                                              );
                                                            });
                                                          })),
                                                ),
                                              ),
                                            ),
                                          );
                                        }

                                        //School Card
                                        else if (index == 2) {
                                          return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                destination = val[index];
                                                _controller1.text = val[index];
                                              });
                                            },
                                            child: Container(
                                              height: 60,
                                              width: 220,
                                              child: Card(
                                                child: ListTile(
                                                  leading: Icon(
                                                    Icons.school,
                                                    size: 25,
                                                    color: Colors.blueGrey[800],
                                                  ),
                                                  title: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8.0),
                                                    child: Text(key[index]),
                                                  ),
                                                  subtitle: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 13.0),
                                                    child: Text(val[index]),
                                                  ),
                                                  trailing: Transform.translate(
                                                      offset: Offset(-20, 0),
                                                      child: IconButton(
                                                          splashRadius: 20.0,
                                                          iconSize: 20.0,
                                                          icon:
                                                              Icon(Icons.edit),
                                                          onPressed: () {
                                                            setState(() {
                                                              showModalBottomSheet<
                                                                  void>(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  return Container(
                                                                    height:
                                                                        250.0,
                                                                    child: Form(
                                                                      key:
                                                                          _formkey,
                                                                      child: Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceEvenly,
                                                                          children: [
                                                                            Text(
                                                                              'Update School',
                                                                              style: TextStyle(
                                                                                color: Colors.blueGrey[800],
                                                                                fontSize: 20.0,
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0.0),
                                                                              child: TextFormField(
                                                                                initialValue: val[index],
                                                                                decoration: const InputDecoration(
                                                                                  hintText: 'School',
                                                                                  hintStyle: TextStyle(color: Colors.black),
                                                                                ),
                                                                                validator: (value) => value.length == 0 ? "Please enter a valid destination" : null,
                                                                                onChanged: (value) {
                                                                                  setState(() {
                                                                                    val[index] = value;
                                                                                  });
                                                                                },
                                                                              ),
                                                                            ),
                                                                            ButtonTheme(
                                                                              height: 40,
                                                                              minWidth: 220,
                                                                              child: RaisedButton(
                                                                                  color: Colors.blueGrey[800],
                                                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
                                                                                  child: Text('Update', style: TextStyle(color: Colors.white, fontSize: 16)),
                                                                                  onPressed: () async {
                                                                                    if (_formkey.currentState.validate()) {
                                                                                      Navigator.pop(context);
                                                                                      await DatabaseService(uid: user.uid).UpdateFavourites(key, val);
                                                                                    }
                                                                                  }),
                                                                            ),
                                                                          ]),
                                                                    ),
                                                                  );
                                                                },
                                                              );
                                                            });
                                                          })),
                                                ),
                                              ),
                                            ),
                                          );
                                        }

                                        //End Card
                                        else if (index == key.length - 1) {
                                          return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                destination = val[index];
                                                _controller1.text = val[index];
                                              });
                                            },
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: 60,
                                                  width: 220,
                                                  child: Card(
                                                    child: ListTile(
                                                      leading: Icon(
                                                        Icons.location_on,
                                                        size: 25,
                                                        color: Colors
                                                            .blueGrey[800],
                                                      ),
                                                      title: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 8.0),
                                                        child: Text(key[index]),
                                                      ),
                                                      subtitle: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 13.0),
                                                        child: Text(val[index]),
                                                      ),
                                                      trailing:
                                                          Transform.translate(
                                                              offset: Offset(
                                                                  -20, 0),
                                                              child: IconButton(
                                                                  splashRadius:
                                                                      20.0,
                                                                  iconSize:
                                                                      20.0,
                                                                  icon: Icon(
                                                                      Icons
                                                                          .edit),
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      showModalBottomSheet<
                                                                          void>(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (BuildContext
                                                                                context) {
                                                                          return Container(
                                                                            height:
                                                                                700.0,
                                                                            child:
                                                                                Form(
                                                                              key: _formkey,
                                                                              child: Column(children: [
                                                                                SizedBox(
                                                                                  height: 20.0,
                                                                                ),
                                                                                Text(
                                                                                  'Update Location/Destination',
                                                                                  style: TextStyle(
                                                                                    fontSize: 20.0,
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 20.0,
                                                                                ),
                                                                                Padding(
                                                                                  padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0.0),
                                                                                  child: TextFormField(
                                                                                    initialValue: key[index],
                                                                                    decoration: textinput.copyWith(
                                                                                      hintText: 'Location',
                                                                                      hintStyle: TextStyle(color: Colors.black),
                                                                                    ),
                                                                                    validator: (value) => value.length == 0 ? "Please enter a valid location" : null,
                                                                                    onChanged: (value) {
                                                                                      setState(() {
                                                                                        key[index] = value;
                                                                                      });
                                                                                    },
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0.0),
                                                                                  child: TextFormField(
                                                                                    initialValue: val[index],
                                                                                    decoration: textinput.copyWith(
                                                                                      hintText: 'Destination',
                                                                                      hintStyle: TextStyle(color: Colors.black),
                                                                                    ),
                                                                                    validator: (value) => value.length == 0 ? "Please enter a valid destination" : null,
                                                                                    onChanged: (value) {
                                                                                      setState(() {
                                                                                        val[index] = value;
                                                                                      });
                                                                                    },
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 10.0,
                                                                                ),
                                                                                FlatButton(
                                                                                    color: Colors.pinkAccent,
                                                                                    child: Text('Update Location/Destination'),
                                                                                    onPressed: () async {
                                                                                      if (_formkey.currentState.validate()) {
                                                                                        Navigator.pop(context);
                                                                                        await DatabaseService(uid: user.uid).UpdateFavourites(key, val);
                                                                                      }
                                                                                    }),
                                                                              ]),
                                                                            ),
                                                                          );
                                                                        },
                                                                      );
                                                                    });
                                                                  })),
                                                    ),
                                                  ),
                                                ),
                                                IconButton(
                                                    icon:
                                                        Icon(Icons.add_circle),
                                                    onPressed: () {
                                                      setState(() {
                                                        setState(() {
                                                          showModalBottomSheet<
                                                              void>(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              var list1 =
                                                                  new List();
                                                              var list2 =
                                                                  new List();
                                                              list1.add(key);
                                                              list2.add(val);
                                                              print(list1);
                                                              print(list2);
                                                              return Container(
                                                                height: 700.0,
                                                                child: Form(
                                                                  key: _formkey,
                                                                  child: Column(
                                                                      children: [
                                                                        SizedBox(
                                                                          height:
                                                                              20.0,
                                                                        ),
                                                                        Text(
                                                                          'Create New Location',
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                20.0,
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              20.0,
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsets.fromLTRB(
                                                                              20.0,
                                                                              0,
                                                                              20.0,
                                                                              0.0),
                                                                          child:
                                                                              TextFormField(
                                                                            decoration:
                                                                                textinput.copyWith(
                                                                              hintText: 'New Value',
                                                                              hintStyle: TextStyle(color: Colors.black),
                                                                            ),
                                                                            validator: (value) => value.length == 0
                                                                                ? "Please enter a valid location"
                                                                                : null,
                                                                            onChanged:
                                                                                (value) {
                                                                              setState(() {
                                                                                value = newlocation;
                                                                                print(newlocation);
                                                                              });
                                                                            },
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsets.fromLTRB(
                                                                              20.0,
                                                                              0,
                                                                              20.0,
                                                                              0.0),
                                                                          child:
                                                                              TextFormField(
                                                                            decoration:
                                                                                textinput.copyWith(
                                                                              hintText: 'New Value',
                                                                              hintStyle: TextStyle(color: Colors.black),
                                                                            ),
                                                                            validator: (value) => value.length == 0
                                                                                ? "Please enter a valid destination"
                                                                                : null,
                                                                            onChanged:
                                                                                (value) {
                                                                              setState(() {
                                                                                value = newdestionation;
                                                                                print(newdestionation);
                                                                              });
                                                                            },
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              10.0,
                                                                        ),
                                                                        FlatButton(
                                                                            color:
                                                                                Colors.pinkAccent,
                                                                            child: Text('Create New Location'),
                                                                            onPressed: () async {
                                                                              list1.add(newlocation);
                                                                              list2.add(newdestionation);
                                                                              if (_formkey.currentState.validate()) {
                                                                                Navigator.pop(context);
                                                                                await DatabaseService(uid: user.uid).UpdateFavourites(list1.toList(), list2.toList());
                                                                              }
                                                                            }),
                                                                        SizedBox(
                                                                          height:
                                                                              30.0,
                                                                        ),
                                                                        Text(
                                                                            'Does Not Work Due To Unresolved Value Issues'),
                                                                      ]),
                                                                ),
                                                              );
                                                            },
                                                          );
                                                        });
                                                      });
                                                    })
                                              ],
                                            ),
                                          );
                                        }

                                        //Misc Card
                                        else if (index > 2) {
                                          return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                destination = val[index];
                                                _controller1.text = val[index];
                                              });
                                            },
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: 60,
                                                  width: 220,
                                                  child: Card(
                                                    child: ListTile(
                                                      leading: Icon(
                                                        Icons.location_on,
                                                        size: 25,
                                                        color: Colors
                                                            .blueGrey[800],
                                                      ),
                                                      title: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 5.0),
                                                        child: Text(key[index]),
                                                      ),
                                                      subtitle: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 13.0),
                                                        child: Text(val[index]),
                                                      ),
                                                      trailing:
                                                          Transform.translate(
                                                              offset: Offset(
                                                                  -20, -3),
                                                              child: IconButton(
                                                                  splashRadius:
                                                                      20.0,
                                                                  iconSize:
                                                                      20.0,
                                                                  icon: Icon(
                                                                      Icons
                                                                          .edit),
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      showModalBottomSheet<
                                                                          void>(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (BuildContext
                                                                                context) {
                                                                          return Container(
                                                                            height:
                                                                                700.0,
                                                                            child:
                                                                                Form(
                                                                              key: _formkey,
                                                                              child: Column(children: [
                                                                                SizedBox(
                                                                                  height: 20.0,
                                                                                ),
                                                                                Text(
                                                                                  'Update Location/Destination',
                                                                                  style: TextStyle(
                                                                                    fontSize: 20.0,
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 20.0,
                                                                                ),
                                                                                Padding(
                                                                                  padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0.0),
                                                                                  child: TextFormField(
                                                                                    initialValue: key[index],
                                                                                    decoration: textinput.copyWith(
                                                                                      hintText: 'Location',
                                                                                      hintStyle: TextStyle(color: Colors.black),
                                                                                    ),
                                                                                    validator: (value) => value.length == 0 ? "Please enter a valid location" : null,
                                                                                    onChanged: (value) {
                                                                                      setState(() {
                                                                                        key[index] = value;
                                                                                      });
                                                                                    },
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0.0),
                                                                                  child: TextFormField(
                                                                                    initialValue: val[index],
                                                                                    decoration: textinput.copyWith(
                                                                                      hintText: 'Destination',
                                                                                      hintStyle: TextStyle(color: Colors.black),
                                                                                    ),
                                                                                    validator: (value) => value.length == 0 ? "Please enter a valid destination" : null,
                                                                                    onChanged: (value) {
                                                                                      setState(() {
                                                                                        val[index] = value;
                                                                                      });
                                                                                    },
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 10.0,
                                                                                ),
                                                                                FlatButton(
                                                                                    color: Colors.pinkAccent,
                                                                                    child: Text('Update Location/Destination'),
                                                                                    onPressed: () async {
                                                                                      if (_formkey.currentState.validate()) {
                                                                                        Navigator.pop(context);
                                                                                        await DatabaseService(uid: user.uid).UpdateFavourites(key, val);
                                                                                      }
                                                                                    }),
                                                                              ]),
                                                                            ),
                                                                          );
                                                                        },
                                                                      );
                                                                    });
                                                                  })),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }
                                      }),
                                );
                              } else {
                                return Container(
                                  width: 0,
                                  height: 0,
                                );
                              }
                            });
                      } else {
                        return Container(
                          width: 0,
                          height: 0,
                        );
                      }
                    }),

                SizedBox(
                  height: 30,
                ),

                // Confirmation button
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ButtonTheme(
                    height: 50,
                    minWidth: 250.0,
                    child: RaisedButton(
                      elevation: 20,
                      color: Colors.blueGrey[800],
                      child: Text(
                        'Confirm Booking ',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      onPressed: () {
                        if (location != null &&
                            destination != null &&
                            location != '' &&
                            destination != '') {
                          setState(() {
                            errortext = '';
                            price = PriceChecker().PriceConfirm(destination);
                            _controller.clear();
                            _controller1.clear();
                            Navigator.of(context)
                                .push(MaterialPageRoute(
                                    builder: (context) => Confirmation(
                                          location: location,
                                          destination: destination,
                                          price: price,
                                          count: count,
                                          checkBoxValue: checkBoxValue,
                                        )))
                                .whenComplete(() {
                              setState(() {
                                location = null;
                                destination = null;
                              });
                            });
                          });
                        } else {
                          setState(() {
                            //snackbar
                            final snackBar = SnackBar(
                              content: Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: Text(
                                      'Please select a valid location and destination')),
                            );
                            Scaffold.of(context).showSnackBar(snackBar);
                          });
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
