import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

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
      home: const MyHomePage(title: 'BarCode'),
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
  TextEditingController message = TextEditingController();
  String? userEnterValue = "welcome";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 150,
            child: SfBarcodeGenerator(
              value: userEnterValue,
              symbology: QRCode(),
              showValue: true,
            ),
          ),
          SizedBox(
            height: 100,
            child: SfBarcodeGenerator(
              value: userEnterValue,
              showValue: true,
            ),
          ),
          SizedBox(
            height: 50,
            width: 300,
            child: TextFormField(
              controller: message,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          InkWell(
            onTap: (() {
              setState(() {
                userEnterValue = message.text;
              });
            }),
            child: Container(
              height: 30,
              width: 100,
              color: Colors.blue,
              child: const Center(child: Text("generate")),
            ),
          )
        ],
      ),
    );
  }
}
