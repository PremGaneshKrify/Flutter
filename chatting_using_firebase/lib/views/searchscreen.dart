import 'package:chatting_using_firebase/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Searchscreen extends StatefulWidget {
  const Searchscreen({Key? key}) : super(key: key);

  @override
  State<Searchscreen> createState() => _SearchscreenState();
}

class _SearchscreenState extends State<Searchscreen> {
  bool searchResult = false;
  DatabaseMethods databaseMethods = DatabaseMethods();
  TextEditingController searchTextEditingController = TextEditingController();
  late QuerySnapshot searchsnapshot;
  initiateSearch() async {
    await databaseMethods
        .getUserByUserName(searchTextEditingController.text)
        .then((value) {
      setState(() {
        searchsnapshot = value;
        searchResult = true;
      });
      searchsnapshot = value;

      // log("diret");
      // log("${searchsnapshot.docs[0]["name"]}");
    });
  }

  Widget searchListTile() {
    // ignore: unnecessary_null_comparison
    return ListView.builder(
        shrinkWrap: true,
        itemCount: searchsnapshot.docs.length,
        itemBuilder: (BuildContext context, int index) {
          return SearchTile(
            email: searchsnapshot.docs[0]["email"],
            username: searchsnapshot.docs[0]["name"],
          );
        });
  }

  createChatroomAndStartConversation(String userName) {
   List<String> user =[];
   
  //  databaseMethods.createChatRoom(chatRoomId, chatRoomMap)
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Search ")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              color: Colors.grey[100],
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchTextEditingController,
                      decoration: const InputDecoration(
                          hintText: "     Search UserName ....",
                          hintStyle: TextStyle(color: Colors.black),
                          border: InputBorder.none),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      initiateSearch();
                    },
                    child: Container(
                        height: 50,
                        width: 50,
                        color: Colors.grey[400],
                        child: const Icon(Icons.search)),
                  )
                ],
              ),
            ),
            searchResult == true ? searchListTile() : const SizedBox(),
          ],
        ),
      ),
    );
  }
}

class SearchTile extends StatelessWidget {
  final String email;

  final String username;

  const SearchTile({Key? key, required this.username, required this.email})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey[100],
        height: 100,
        width: 100,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Column(
                children: [
                  Text(
                    username,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    email,
                    style: const TextStyle(fontSize: 18),
                  )
                ],
              ),
              const Spacer(),
              ElevatedButton(onPressed: () {}, child: const Text("MESSAGE"))
            ],
          ),
        ));
  }
}
