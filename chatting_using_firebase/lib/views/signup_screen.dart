import 'dart:developer';

import 'package:flutter/material.dart';

class SiginUpscreen extends StatefulWidget {
  const SiginUpscreen({Key? key}) : super(key: key);

  @override
  State<SiginUpscreen> createState() => _SiginUpscreenState();
}

class _SiginUpscreenState extends State<SiginUpscreen> {
  final fromKey = GlobalKey<FormState>();
  TextEditingController userNameTextEditingcontroller = TextEditingController();
  TextEditingController emailTextEditingcontroller = TextEditingController();

  TextEditingController passwordTextEditingcontroller = TextEditingController();

  signMeUp() {
    if (fromKey.currentState!.validate()) {}
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
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 50,
              child: Form(
                key: fromKey,
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
                            : "Please Enter Correct Email";
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
                        signMeUp();
                        log("hello");
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
                        children: const [
                          Text("Already have a account"),
                          Text(
                            "Sigin here",
                            style:
                                TextStyle(decoration: TextDecoration.underline),
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
    );
  }
}
