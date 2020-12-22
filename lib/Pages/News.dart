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
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Text(
              'News',
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey[800]),
            ),
          ),
        ),
        SizedBox(height: 20.0),
        StreamBuilder<NewsFunc>(
          stream:  UserNews(docname: 'newstuff').newsstuff,
          // ignore: missing_return
          builder: (context , snapshot){
            NewsFunc newslol2 = snapshot.data;
            if (snapshot.hasData){
              var arr = newslol2.news;
              return Expanded(
                  child: ListView.builder(
                      itemCount: arr.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 300.0,
                          width: 200.0,
                          child: Card(
                            margin: EdgeInsets.only(
                                top: 5, left: 10, right: 10, bottom: 5),
                            elevation: 7,
                            // Prevents picture from overriding card borders
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            borderOnForeground: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                                children: [
                                AspectRatio(
                                aspectRatio : 8.5/1,
                                child: Padding(
                                    padding: EdgeInsets.only(top: 8.0, left: 5.0 ),
                                    child: Text( arr[index], style :TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                    ))),
                          ),
                          Container(
                            height: 3.0,
                            width: 1000.0,
                            color: Colors.grey[500],
                          ),

                          Expanded(
                            child: Container(
                              height: 2.0,
                              width: 1000.0,
                              color: Colors.blueAccent,
                            ),
                          )
                          ],
                        ),
                        ),

                        );
                      })
              );
            }
            else{
              return Container(
                child: Text('Nothing To Show'),
                height: 10,
                width: 10,
              );
            }
          },
        ),
      ]
      ),
    );
  }
}
