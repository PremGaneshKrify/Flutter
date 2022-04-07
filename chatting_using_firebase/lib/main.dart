import 'package:chatting_using_firebase/helper/authenticate.dart';
import 'package:chatting_using_firebase/views/chatrooms_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  late bool userIsLoggedIn = true;

  MyApp({Key? key}) : super(key: key);

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
            : const Center(child: Authenticate()));
  }
}
