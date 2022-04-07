import 'dart:developer';

import 'package:chatting_using_firebase/services/database.dart';
import 'package:flutter/material.dart';

class Searchscreen extends StatefulWidget {
  const Searchscreen({Key? key}) : super(key: key);

  @override
  State<Searchscreen> createState() => _SearchscreenState();
}

class _SearchscreenState extends State<Searchscreen> {
  DatabaseMethods databaseMethods = DatabaseMethods();
  TextEditingController searchTextEditingController = TextEditingController();
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
                      databaseMethods
                          .getUserByUserName(searchTextEditingController.text)
                          .then((value) {
                        log(value.toString());
                      });
                    },
                    child: Container(
                        height: 50,
                        width: 50,
                        color: Colors.grey[400],
                        child: const Icon(Icons.search)),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
