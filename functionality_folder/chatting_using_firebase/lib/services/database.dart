import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  getUserByUserName(String username) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("name", isEqualTo: username)
        .get();
  }

  getUserByUserEmail(String userEmail) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: userEmail)
        .get();
  }

  uploadUserInfo(userMap, userUID) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc("$userUID")
        .set(userMap)
        .catchError((e) {
      log(e.toString());
    });
  }

  // uploadUserInfo(userMap, userUID) {
  //   return FirebaseFirestore.instance
  //       .collection('users')
  //       .add(userUID)
  //       .catchError((e) {
  //     log(e.toString());
  //   });
  // }
  getLastMessage(chatRoomId) {
    FirebaseFirestore.instance
        .collection('ChatRoom')
        .doc(chatRoomId)
        .collection("chats")
        .doc("RWNxd0gVd1IFx1ZaV7NF")
        .collection("message")
        .snapshots()
        .listen((event) {
      log('------------------------------------------------------------------------------$event.docs.length-----------------get last message------');
      print(event.docs.length);
    });
    return FirebaseFirestore.instance
        .collection('ChatRoom')
        .doc(chatRoomId)
        .collection("chats")
        .doc("RWNxd0gVd1IFx1ZaV7NF")
        .collection("message");
  }

  createChatRoom(String chatRoomId, chatRoomMap) {
    FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomId)
        .set(chatRoomMap)
        .catchError((e) {
      log(e.toString());
    });
  }

  addConversationMessages(String chatRoomId, messageMap) {
    FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .add(messageMap)
        .catchError((e) {
      log(e.toString());
    });
  }

  // getConversationMessages(String chatRoomId) async{
  //   return FirebaseFirestore.instance
  //       .collection("ChatRoom")
  //       .doc(chatRoomId)
  //       .collection("chats").orderBy("time")
  //       .snapshots();
  // }
  getConversationMessages(String chatRoomId) async {
    return FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy("time")
        .snapshots(includeMetadataChanges: true);
  }

  getChatRoom(String userName) {
    return FirebaseFirestore.instance
        .collection("ChatRoom")
        .where("users", arrayContains: userName)
        .snapshots();
  }
}
