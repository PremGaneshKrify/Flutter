import 'package:chatting_using_firebase/helper/constants.dart';
import 'package:chatting_using_firebase/services/database.dart';
import 'package:flutter/material.dart';

class ConversationScreen extends StatefulWidget {
  final String chatRoomId;

  const ConversationScreen({Key? key, required this.chatRoomId})
      : super(key: key);

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

Stream? chatMessageStream;

class _ConversationScreenState extends State<ConversationScreen> {
  TextEditingController messageTextEditingController = TextEditingController();
  DatabaseMethods databaseMethods = DatabaseMethods();

  @override
  void initState()  {
    print("_________inti entered______________");
     databaseMethods.getConversationMessages(widget.chatRoomId).then((value) async {
       chatMessageStream =  await value;
      setState(()  {
        chatMessageStream =   value;
      });
        print("________________init messsage steam__________________--");
        print(chatMessageStream);
        print(chatMessageStream!.length);
    });

    super.initState();
  }

  Widget chatMessageList() {
    print("_________cht message list entered______________");
    return StreamBuilder(
        stream: chatMessageStream,
        builder: (context, snapshot) {
          return ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return messageTile("hai");
              });
        });
  }

  sendMessage() {
    if (messageTextEditingController.text.isNotEmpty) {
      Map<String, String> messageMap = {
        "message": messageTextEditingController.text,
        "sendBy": Constants.myName,
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
      appBar: AppBar(title: const Text("Conversation room")),
      body: Stack(
        children: [
          chatMessageList(),
          Container(
            alignment: Alignment.bottomCenter,
            color: Colors.grey[100],
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
                    print("_________send messege called______________");
                  },
                  child: Container(
                      height: 50,
                      width: 50,
                      color: Colors.grey[400],
                      child: const Icon(Icons.send)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget messageTile(String message) {
  return Text(message);
}
