import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'package:twitch_clone/config/appId.dart';
import 'package:twitch_clone/providers/user_provider.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:twitch_clone/resources/firestore_methods.dart';
import 'package:twitch_clone/screens/home_screen.dart';

import '../widgets/chat.dart';

class BroadcastScreen extends StatefulWidget {
  bool isBroadcaster;
  final String channelId;

  BroadcastScreen({
    Key? key,
    required this.isBroadcaster,
    required this.channelId,
  }) : super(key: key);

  @override
  State<BroadcastScreen> createState() => _BroadcastScreenState();
}

class _BroadcastScreenState extends State<BroadcastScreen> {
  late final RtcEngine _engine;
  bool switchCamera = true;
  bool isMuted = false;
  List<int> remoteUid = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initEngine();
  }

  void _initEngine() async {
    print('from broadcast screen');
    _engine = await RtcEngine.createWithContext(RtcEngineContext(appId));
    _addListeners();
    await _engine.enableVideo();
    await _engine.startPreview();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    if (widget.isBroadcaster)
      _engine.setClientRole(ClientRole.Broadcaster);
    else
      _engine.setClientRole(ClientRole.Audience);

    _joinChannel();
  }

  void _joinChannel() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      await [Permission.microphone, Permission.camera].request();
    }
    await _engine.joinChannelWithUserAccount(tempToken, 'test',
        Provider.of<UserProvider>(context, listen: false).user.uid);
  }

// user joined in or left
  void _addListeners() {
    _engine.setEventHandler(
        RtcEngineEventHandler(joinChannelSuccess: (channel, uid, elapsed) {
      debugPrint('joinChannelSuccess $channel $uid $elapsed');
    }, userJoined: (uid, elapsed) {
      debugPrint('userJoined $uid $elapsed');
      setState(() {
        remoteUid.add(uid);
      });
    }, userOffline: (uid, reason) {
      debugPrint('userOffline $uid $reason');
      setState(() {
        remoteUid.removeWhere((element) => element == uid);
      });
    }, leaveChannel: (stats) {
      debugPrint('leaveChannel $stats');
      setState(() {
        remoteUid.clear();
      });
    }));
  }

  _leaveChannel() async {
    await _engine.leaveChannel();
    if ('${Provider.of<UserProvider>(context, listen: false).user.uid}${Provider.of<UserProvider>(context, listen: false).user.username}' ==
        widget.channelId) {
      await FireStoreMethods().endLiveStream(widget.channelId);
    } else {
      await FireStoreMethods().updateViewCount(widget.channelId, false);
    }
    Navigator.pushReplacementNamed(context, HomeScreen.routeName);
  }

  void _switchCamera() {
    _engine.switchCamera().then((value) {
      setState(() {
        switchCamera = !switchCamera;
      });
    }).catchError((err) {
      debugPrint('Switch Camera $err');
    });
  }

  void onToggleMute() async {
    setState(() {
      isMuted = !isMuted;
    });
    await _engine.muteLocalAudioStream(isMuted);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return WillPopScope(
      onWillPop: () async {
        await _leaveChannel();
        return Future.value(true);
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              _renderVideo(user),
              if ('${user.uid}${user.username}' == widget.channelId)
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: _switchCamera,
                      child: Text('Switch Camera'),
                    ),
                    InkWell(
                      onTap: onToggleMute,
                      child: Text(isMuted ? 'Unmute' : 'Mute'),
                    )
                  ],
                ),
              Expanded(
                  child: Chat(
                channelId: widget.channelId,
              ))
            ],
          ),
        ),
      ),
    );
  }

  _renderVideo(user) {
    return AspectRatio(
        aspectRatio: 16 / 9,
        child: "${user.uid}${user.username}" == widget.channelId
            ? RtcLocalView.SurfaceView(
                zOrderMediaOverlay: true,
                zOrderOnTop: true,
              )
            : remoteUid.isNotEmpty
                ? kIsWeb
                    ? RtcRemoteView.SurfaceView(
                        uid: remoteUid[0],
                        channelId: widget.channelId,
                      )
                    : RtcRemoteView.TextureView(
                        uid: remoteUid[0],
                        channelId: widget.channelId,
                      )
                : Container());
  }
}
