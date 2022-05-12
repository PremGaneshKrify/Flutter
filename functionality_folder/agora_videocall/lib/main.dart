// ignore_for_file: deprecated_member_use, library_prefixes

import 'dart:async';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;

const appId = "0a348c70726e4be39fcda8906713c035";
const token =
    "0060a348c70726e4be39fcda8906713c035IADciPYoKaAkKsthIuJ2YIwtO2C8clIVOv3CnWIqxPCY1QS7NZkAAAAAEAD9FOMnvlV6YgEAAQC+VXpi";

void main() {
  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final bool _joined = false;
  int _remoteUid = 0;
  final bool _switch = false;
  //int? _remoteUid;
  RtcEngine? _engine;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initForAgora();
  }

  Future<void> initForAgora() async {
    await [Permission.microphone, Permission.camera].request();
    _engine = await RtcEngine.createWithConfig(RtcEngineConfig(appId));
    await _engine!.enableVideo();
    _engine!.setEventHandler(
      RtcEngineEventHandler(joinChannelSuccess: ((channel, uid, elapsed) {
        print("local user $uid joined");
        setState(() {
          _remoteUid = uid;
        });
      }), userJoined: (int uid, int elapsed) {
        print("remote user $uid joined");
      }),
    );
    // VideoEncoderConfiguration configuration = VideoEncoderConfiguration();
    // configuration.dimensions = const Size(1920, 1080) as VideoDimensions?;
    await _engine!.joinChannel(token, "seccha", null, 0);
  }

// crate ui with local view and remote view
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("agora video call"),
      ),
      body: Stack(
        children: [
          Center(
            child: _renderRemoteVideo(_remoteUid),
          ),
          Container(
            color: Colors.white,
            width: 110,
            height: 110,
            child: Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                width: 100,
                height: 100,
                child: Center(
                  child: _renderLocalPreview(),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

// current user video
Widget _renderLocalPreview() {
  print("// current user video");
  return const RtcLocalView.SurfaceView();
}

// remote user video
Widget _renderRemoteVideo(_remoteUid) {
  if (_remoteUid != null) {
    print("// remote user video ---------$_remoteUid--------------------");
    return RtcRemoteView.SurfaceView(
      channelId: "seccha",
      uid: _remoteUid,
    );
  } else {
    return const Text(
      "please wait remote user join",
      textAlign: TextAlign.center,
    );
  }
}
