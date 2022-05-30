import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var count = 10;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),

      // body: Stack(
      //   children: [
      //     Center(child: Container(height: 250, width: 250, color: Colors.black)),
      //     Center(
      //       child: Container(
      //         height: 200,
      //         width: 200,
      //         color: Colors.white,
      //       ),
      //     ),
      //     Center(
      //       child: Container(
      //         height: 150,
      //         width: 150,
      //         color: Colors.blue,
      //       ),
      //     ),
      //     Center(
      //       child: Container(
      //         height: 100,
      //         width: 100,
      //         color: Colors.red,
      //       ),
      //     ),
      //   ],

      //  )

      body: Container(
        color: Colors.blue,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: GestureDetector(
            onTap: () {
          
              setState(() {
                   count = count + 1;
              });
            },
            child: Container(
              margin: const EdgeInsets.all(20),
              color: Colors.pink,
              child: Text(
                "$count",
                style: const TextStyle(fontSize: 50),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
