import 'package:flutter/material.dart';
import 'package:rapidkl/Pages/Home.dart';
import 'package:rapidkl/Services/Authenticate.dart';
import 'package:provider/provider.dart';
import 'package:rapidkl/Services/User.dart';

class  Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final user = Provider.of<User>(context);

    //check to see if user is logged in or not//

    if(user == null){
      return Auth();
    }
    else {
      return MyApp();
    }
  }
}
