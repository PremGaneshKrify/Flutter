import 'package:flutter/material.dart';
import 'package:image_picker_example/widget/asset_image_widget.dart';
import 'package:image_picker_example/widget/file_memory_image_widget.dart';
import 'package:image_picker_example/widget/network_image_widget.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const String title = 'Image Example';

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(primarySwatch: Colors.deepOrange),
        home: const MainPage(title: title),
      );
}

class MainPage extends StatefulWidget {
  final String title;

  const MainPage({
    required this.title,
  });

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int index = 2;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(child: buildPages()),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          selectedItemColor: Colors.red,
          items: const [
            BottomNavigationBarItem(
              icon: Text('Image'),
              label:'Network',
            ),
            BottomNavigationBarItem(
              icon: Text('Image'),
            label: 'Asset', 
            ),
            BottomNavigationBarItem(
              icon: Text('Image'),
            label: 'Memory/File',
            ),
          ],
          onTap: (int index) => setState(() => this.index = index),
        ),
      );

  Widget buildPages() {
    switch (index) {
      case 0:
        return NetworkImageWidget();
      case 1:
        return AssetImageWidget();
      case 2:
        return FileMemoryImageWidget();
      default:
        return Container();
    }
  }
}