import 'package:chatting_using_firebase/services/auth.dart';
import 'package:chatting_using_firebase/views/searchscreen.dart';
import 'package:flutter/material.dart';

import '../helper/authenticate.dart';

class ChatRoom extends StatefulWidget {
  const ChatRoom({Key? key}) : super(key: key);

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  AuthServices authServices = AuthServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat Room"),
        actions: [
          GestureDetector(
            onTap: (() {
              authServices.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const Authenticate(),
                ),
              );

              // authServices
              //     .signUpWithEmailAndPassoword("asdj11@gmail.com", "fsdkjk")
              //     .then((value) async {});
            }),
            child: const Icon(Icons.exit_to_app),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Searchscreen(),
            ),
          );
        },
        child: const Icon(Icons.search),
      ),
      body: Container(),
    );
  }
}
