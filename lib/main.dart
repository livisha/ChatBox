import 'package:chatapp/helper/authenticate.dart';
import 'package:chatapp/helper/helperfunction.dart';
import 'package:chatapp/views/chatroomscreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool userIsLoggedIn=false;
  @override
  void initState() {
   getLoggedInState();
    super.initState();
  }
getLoggedInState()async{
    await HelperFunction.getuserLoggedInSharedPreference()
        .then((value){
setState(() {
  userIsLoggedIn=value;
});
    });
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       scaffoldBackgroundColor: Colors.black87,
        primarySwatch: Colors.blue,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:userIsLoggedIn?ChatRoom(): Authenticate(),
    );
  }
}




