import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyController extends GetxController {
  var name = "JOHN".obs;
  var age = 33.obs;

  incrementAge() {
    age++;
  }

  changeName(String s) {
    name = RxString(s);
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    MyController controller = MyController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('widget.title'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Obx(() => Text(controller.name.toString())),
            Obx(() => Text('Age: ${controller.age}')),
            TextButton(
                onPressed: () {
                  controller.incrementAge();
                },
                child: const Text('add age')),
            TextField(
              controller: textEditingController,
            ),
            TextButton(
                onPressed: () {
                  controller.name = controller.changeName(textEditingController.text);
                },
                child: const Text('ChangeName'))
          ],
        ),
      ),
    );
  }
}