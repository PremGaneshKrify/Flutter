import 'package:flutter/material.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
          child: Column(
            children: [
              ElevatedButton(onPressed: () {}, child: const Text("Pay  500/-"))
            ],
          ),
        ));
  }
}

Future<void> makepayment() async {
//  final url = Uri.parse( );
}
