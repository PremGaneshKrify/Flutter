import 'package:agora_uikit/agora_uikit.dart';
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
      home: const MyHomePage(title: 'Agora video call latest'),
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
  final AgoraClient _client = AgoraClient(
    agoraConnectionData: AgoraConnectionData(
        appId: '0a348c70726e4be39fcda8906713c035',
        channelName: 'fluttering',
        tempToken:
            '0060a348c70726e4be39fcda8906713c035IADcbTN0JjTWxLtpG1TlcOR8zO4ghuIfYKRScb0AGfndBr2YShYAAAAAEAA5DUG6Kjx/YgEAAQApPH9i'),
    enabledPermission: [],
  );

  @override
  void initState() {
    // TODO: implement initState
    _initAgora();
  }

  Future<void> _initAgora() async {
    await _client.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        // appBar: AppBar(
        //   automaticallyImplyLeading: false,
        //   title: const Text('video call'),
        // ),
        body: Scaffold(
            appBar: AppBar(
              title: Text(widget.title),
            ),
            body: SafeArea(
              child: Stack(children: [
                AgoraVideoViewer(
                  client: _client,
                  layoutType: Layout.floating,
                  showNumberOfUsers: true,
                ),
                AgoraVideoButtons(
                  client: _client,
                  enabledButtons: const [
                    BuiltInButtons.toggleCamera,
                    BuiltInButtons.callEnd,
                    BuiltInButtons.toggleMic
                  ],
                )
              ]),
            )),
      ),
      onWillPop: () async => false,
    );
  }
}
