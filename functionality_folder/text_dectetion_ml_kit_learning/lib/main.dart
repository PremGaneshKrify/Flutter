import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

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
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Text Detection'),
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
  bool textScanning = false;
  File? imageFile;
  String scannedText = '';

  @override
  // initState() {
  //   super.initState();

  //   () async {
  //     _permissionStatus = await Permission.storage.status;

  //     if (_permissionStatus != PermissionStatus.granted) {
  //       PermissionStatus permissionStatus = await Permission.storage.request();
  //       setState(() {
  //         _permissionStatus = permissionStatus;
  //       });
  //     }
  //   }();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Center(child: Text(widget.title)),
        title: const Center(child: Text('సూపర్‌ స్టార్‌ మహేశ్‌బాబు,')),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.blue,
          child: Column(
            children: [
              if (textScanning) const CircularProgressIndicator(),
              if (!textScanning && imageFile == null)
                Container(
                  height: 300,
                  width: 300,
                  color: Colors.grey.shade100,
                ),
              if (imageFile != null) Image.file(File(imageFile!.path)),
              Padding(
                padding: const EdgeInsets.only(left: 110),
                child: Container(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                            onPressed: () {
                              getImage(ImageSource.camera);
                            },
                            icon: const Icon(Icons.camera_enhance_rounded)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                            onPressed: () {
                              print(
                                  "------------------------gallery-------------");
                              getImage(ImageSource.gallery);
                            },
                            icon: const Icon(Icons.image)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                            onPressed: () {
                              print("-------------------------------------");
                            },
                            icon: const Icon(Icons.mic)),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                child: Text(scannedText.toString()),
              )
            ],
          ),
        ),
      ),
    );
  }

  void getImage(ImageSource source) async {
    print("------------------------------get image entered-------");
    try {
      print("----------entered try---------------------------");
      final pickedImage = await ImagePicker().pickImage(source: source);
      print("-------------------------------------");
      if (pickedImage != null) {
        print(
            "---------------------${pickedImage != null}---------pickedImage-------");

        setState(() {
          textScanning = true;
          imageFile = File(pickedImage.path);
          print("--------------------------imagefile.path-----------");
          print(imageFile!.path);
          print("-------------------------imagefile.path-----------");
        });
        getRecognisedText(pickedImage);
      }
    } catch (e) {
      textScanning = false;
      imageFile = null;
      setState(() {
        scannedText = "Error while scanning";
      });
    }
  }

  void getRecognisedText(XFile image) async {
    final inputImage = InputImage.fromFilePath(image.path);
    print("-------------------------------------");
    print(inputImage);
    print("-------------------------------------");
    final textDetector = GoogleMlKit.vision.textRecognizer();
    RecognizedText recognizedText = await textDetector.processImage(inputImage);

    await textDetector.close();
    scannedText = '';
    for (TextBlock block in recognizedText.blocks) {
      for (TextLine line in block.lines) {
        scannedText = scannedText + line.text + '\n';
      }
    }
    textScanning = false;
    setState(() {});
  }
}
