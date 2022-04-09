import 'package:chatting_using_firebase/helper/authenticate.dart';
import 'package:chatting_using_firebase/views/chatrooms_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'helper/helperfunctions.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  late bool userIsLoggedIn = false;

  MyApp({Key? key}) : super(key: key);

  void initState() {
    getLoggedInState();
  }

  getLoggedInState() async {
    await HelperFunctions.getUserLoggedInSharedPreference().then((value) {
      print(value);
      // setState(() {
      //   userIsLoggedIn = value!;
      // });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.grey[200],
          primarySwatch: Colors.blue,
        ),
        // ignore: unnecessary_null_comparison
        home: userIsLoggedIn != null
            ? userIsLoggedIn
                ? const ChatRoom()
                : const Authenticate()
            : Container(
                child: const Center(
                child: Authenticate(),
              )));
  }
}
