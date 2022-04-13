import 'dart:developer';

import 'package:chatting_using_firebase/services/auth.dart';
import 'package:chatting_using_firebase/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../helper/helperfunctions.dart';
import 'chatrooms_screen.dart';

class SignInScreen extends StatefulWidget {
  final Function toggleView;

  const SignInScreen(this.toggleView, {Key? key}) : super(key: key);
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  QuerySnapshot? snapshotUserInfo;
  DatabaseMethods databaseMethods = DatabaseMethods();
  AuthServices authServices = AuthServices();
  final formKey = GlobalKey<FormState>();
  TextEditingController emailTextEditingcontroller = TextEditingController();
  TextEditingController passwordTextEditingcontroller = TextEditingController();
  bool isLoading = false;
  String? usernamefromsignin;
  signIn() {
    if (formKey.currentState!.validate()) {
      log("_____________________________________________----");
      log(" if logic ${formKey.currentState!.validate()}");
      log("user entered data");
      log(emailTextEditingcontroller.text);
      log(passwordTextEditingcontroller.text);

      setState(() {
        isLoading = true;
        HelperFunctions.saveUserEmailSharedPreference(
            emailTextEditingcontroller.text);
        HelperFunctions.saveUserLoggedInSharedPreference(true);
      });

      authServices
          .signinWithEmailAndPassword(emailTextEditingcontroller.text,
              passwordTextEditingcontroller.text)
          .then((value) {
        print("FIREBASE RESPONSE...............");
        print(value);

        if (value != null) {
          databaseMethods
              .getUserByUserEmail(emailTextEditingcontroller.text)
              .then((value) async {
            snapshotUserInfo = value;
            log("USER INFO AFTER SIGN IN.................");
            log(snapshotUserInfo.toString());
            log(snapshotUserInfo!.docs.toString());
            log(snapshotUserInfo!.docs[0]["name"]);
            HelperFunctions.saveUserNameSharedPreference(
                snapshotUserInfo?.docs[0]["name"]);
            print(usernamefromsignin);
          });
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatRoom(
                        userNameFromSignin: usernamefromsignin.toString(),
                      )));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chatting using Firebase"),
      ),
      body: Builder(builder: (context) {
        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height - 50,
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFormField(
                            controller: emailTextEditingcontroller,
                            validator: (value) {
                              return RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(value!)
                                  ? null
                                  : "Please Enter valid Email";
                            },
                            onChanged: (val) {
                              final trimVal = val.trim();
                              if (val != trimVal) {
                                setState(() {
                                  emailTextEditingcontroller.text = trimVal;
                                  emailTextEditingcontroller.selection =
                                      TextSelection.fromPosition(
                                          TextPosition(offset: trimVal.length));
                                });
                              }
                            },
                            decoration: const InputDecoration(
                                hintText: "Email",
                                hintStyle: TextStyle(color: Colors.blue)),
                          ),
                          TextFormField(
                            onChanged: (val) {
                              final trimVal = val.trim();
                              if (val != trimVal) {
                                setState(() {
                                  emailTextEditingcontroller.text = trimVal;
                                  emailTextEditingcontroller.selection =
                                      TextSelection.fromPosition(
                                          TextPosition(offset: trimVal.length));
                                });
                              }
                            },
                            controller: passwordTextEditingcontroller,
                            validator: (value) {
                              return value!.length > 6
                                  ? null
                                  : "Please enter  length of 8 charater password";
                            },
                            decoration: const InputDecoration(
                                hintText: "password",
                                hintStyle: TextStyle(color: Colors.blue)),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            alignment: Alignment.topRight,
                            child: TextButton(
                              onPressed: () {},
                              child: const Text("Forgot password"),
                            ),
                          ),
                          InkWell(
                            onTap: (() {
                              signIn();
                            }),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(250)),
                              height: MediaQuery.of(context).size.height * 0.08,
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: const Center(child: Text("Sign In")),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                    colors: [Colors.grey, Colors.black38]),
                                borderRadius: BorderRadius.circular(250)),
                            height: MediaQuery.of(context).size.height * 0.08,
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: const Center(child: Text("Google")),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Text("Don't have a account"),
                                InkWell(
                                  onTap: () {
                                    widget.toggleView();
                                  },
                                  child: const Text(
                                    "Register here",
                                    style: TextStyle(
                                        decoration: TextDecoration.underline),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            isLoading == true
                ? const Center(child: CircularProgressIndicator())
                : const SizedBox()
          ],
        );
      }),
    );
  }
}
