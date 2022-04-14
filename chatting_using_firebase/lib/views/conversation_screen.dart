import 'package:chatting_using_firebase/helper/constants.dart';
import 'package:chatting_using_firebase/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ConversationScreen extends StatefulWidget {
  final String chatRoomId;
  final String searchResultName;

  const ConversationScreen(
      {Key? key, required this.chatRoomId, required this.searchResultName})
      : super(key: key);

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  TextEditingController messageTextEditingController = TextEditingController();
  DatabaseMethods databaseMethods = DatabaseMethods();
  Stream? chatMessageStream;
  @override
  void initState() {
    super.initState();
  }

  chatMessageList() {
    final Stream<QuerySnapshot> messagesList = FirebaseFirestore.instance
        .collection('ChatRoom')
        .doc(widget.chatRoomId)
        .collection("chats")
        .orderBy("time", descending: false)
        .snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: messagesList,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: data["sendBy"] == Constants.myName ? Alignment.centerLeft : Alignment.centerRight,
                child: SizedBox(
                    height: 25,
                    
                    child: Text(
                      "${data['message']}",
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    )),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  sendMessage() {
    if (messageTextEditingController.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        "message": messageTextEditingController.text,
        "sendBy": Constants.myName,
        "time": DateTime.now().millisecondsSinceEpoch
      };
      databaseMethods.addConversationMessages(widget.chatRoomId, messageMap);
      setState(() {
        messageTextEditingController.text = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.searchResultName)),
      body: Container(
        color: Colors.black,
        child: Stack(
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageTextEditingController,
                      decoration: const InputDecoration(
                          hintText: "Type your message here ....",
                          hintStyle: TextStyle(color: Colors.black),
                          border: InputBorder.none),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      sendMessage();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          height: 50,
                          width: 50,
                          color: Colors.white,
                          child: const Icon(Icons.send)),
                    ),
                  )
                ],
              ),
            ),
            Container(
              color: Colors.black,
              height: MediaQuery.of(context).size.height * 0.8,
              child: chatMessageList(),
            )
          ],
        ),
      ),
    );
  }
}
