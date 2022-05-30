import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('mcs students tasks'),
        ),
        body: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  color: Colors.black,
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  height: 50,
                  width: 50,
                  color: Colors.blue,
                ),
              ],
            ),
            Container(
              height: 100,
              width: 100,
              color: Colors.blue,
              child: const Icon(Icons.call),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              width: 50,
              color: Colors.blue,
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              width: 50,
              color: Colors.blue,
            ),
            Container(
              child: const Text("this is first line"),
            ),
          ],
        ));
  }
}
