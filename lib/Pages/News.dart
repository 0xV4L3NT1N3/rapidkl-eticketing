import 'package:flutter/material.dart';
import 'package:rapidkl/Services/User.dart';
import 'package:rapidkl/Services/database.dart';
import 'package:provider/provider.dart';

class News extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  final List<String> items = ["hello", "world", "lmao"];

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Scaffold(
      body: Column(children: [
        Row(
          children: [
            // Page title
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 50),
                child: Text(
                  'News',
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[800]),
                ),
              ),
            ),
            // Notification bell
            Padding(
              padding: const EdgeInsets.only(top: 50.0, left: 210),
              child: IconButton(
                  icon: Icon(Icons.notifications),
                  color: Colors.red,
                  onPressed: () {}),
            )
          ],
        ),

        // News cards
        StreamBuilder<NewsFunc>(
          stream: UserNews(docname: 'newstuff').newsstuff,
          // ignore: missing_return
          builder: (context, snapshot) {
            NewsFunc newslol2 = snapshot.data;
            if (snapshot.hasData) {
              var arr = newslol2.news;
              return Expanded(
                  child: ListView.builder(
                      itemCount: arr.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 120,
                          child: Card(
                            margin:
                                EdgeInsets.only(left: 10, right: 10, bottom: 5),
                            elevation: 2,
                            // Prevents picture from overriding card borders
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            borderOnForeground: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  height: 120,
                                  width: 120,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  child: Image.network(
                                      'https://apicms.thestar.com.my/uploads/images/2020/06/06/709535.jpg',
                                      fit: BoxFit.fill),
                                ),
                                Positioned(
                                  left: 130,
                                  top: 15,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Get the new MY30 ',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blueGrey[800],
                                            fontSize: 22),
                                      ),
                                      Text(
                                          'Available for a limited time \n only at selected stations',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 15)),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 110.0, top: 10),
                                        child: Text('2 hours ago',
                                            style:
                                                TextStyle(color: Colors.grey)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }));
            } else {
              return Container(
                height: 10,
                width: 10,
              );
            }
          },
        ),
      ]),
    );
  }
}
