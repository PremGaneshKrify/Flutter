import 'dart:developer';
import 'package:chatting_using_firebase/helper/helperfunctions.dart';
import 'package:chatting_using_firebase/services/auth.dart';
import 'package:chatting_using_firebase/services/database.dart';
import 'package:chatting_using_firebase/views/chatrooms_screen.dart';
import 'package:flutter/material.dart';

class SignUpscreen extends StatefulWidget {
  final Function toggleView;

  // ignore: use_key_in_widget_constructors
  const SignUpscreen(this.toggleView);
  @override
  State<SignUpscreen> createState() => _SignUpscreenState();
}

class _SignUpscreenState extends State<SignUpscreen> {
  AuthServices authServices = AuthServices();
  DatabaseMethods databaseMethods = DatabaseMethods();
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  TextEditingController userNameTextEditingcontroller = TextEditingController();
  TextEditingController emailTextEditingcontroller = TextEditingController();
  TextEditingController passwordTextEditingcontroller = TextEditingController();

  signMeUp() async {
    if (formKey.currentState!.validate()) {
      log("signMeUp entered");
      setState(() {
        isLoading = true;
        HelperFunctions.saveUserLoggedInSharedPreference(true);
        HelperFunctions.saveUserEmailSharedPreference(
            emailTextEditingcontroller.text);
        HelperFunctions.saveUserNameSharedPreference(
            userNameTextEditingcontroller.text);
      });
      authServices
          .signUpWithEmailAndPassoword(emailTextEditingcontroller.text,
              passwordTextEditingcontroller.text)
          .then((value) async {
        log("Response from firebase signup:");
        log(value.toString());

        Map<String, String> userInfoMap = {
          "name": userNameTextEditingcontroller.text,
          "email": emailTextEditingcontroller.text
        };

        await databaseMethods.uploadUserInfo(userInfoMap);

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => ChatRoom(
                      userNameFromSignin: userNameTextEditingcontroller.text,
                    )));
      });
    }
    log("not enterd if case");
    log(formKey.currentState!.validate().toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chatting using Firebase"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height - 50,
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          validator: (value) {
                            return value!.isEmpty || value.length < 4
                                ? "Plase enter valid user name"
                                : null;
                          },
                          controller: userNameTextEditingcontroller,
                          decoration: const InputDecoration(
                              hintText: "User Name",
                              hintStyle: TextStyle(color: Colors.blue)),
                        ),
                        TextFormField(
                          validator: (value) {
                            return RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value!)
                                ? null
                                : "Please Enter valid Email";
                          },
                          controller: emailTextEditingcontroller,

                          /// this will not allow user to enter white spaces in field
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
                          validator: (value) {
                            return value!.length > 6
                                ? null
                                : "Please enter  length of 8 charater password";
                          },
                          controller: passwordTextEditingcontroller,
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
                            onPressed: () {
                              log("hello");
                            },
                            child: const Text("Forgot password"),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            log(" signUP Button Pressed ");
                            signMeUp();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(250)),
                            height: MediaQuery.of(context).size.height * 0.08,
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: const Center(child: Text("Sign up")),
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
                              const Text("Already have a account"),
                              InkWell(
                                onTap: () {
                                  widget.toggleView();
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "Sigin here",
                                    style: TextStyle(
                                        decoration: TextDecoration.underline),
                                  ),
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
              isLoading == true
                  ? const Center(child: CircularProgressIndicator())
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
