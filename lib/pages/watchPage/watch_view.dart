// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:watch_and_show/core/animated_button.dart';
import 'package:watch_and_show/global.dart';
import 'package:watch_and_show/shared/added_video_link.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class WatchPage extends StatefulWidget {
  const WatchPage({Key? key}) : super(key: key);

  @override
  State<WatchPage> createState() => _WatchPageState();
}

class _WatchPageState extends State<WatchPage> {
  late YoutubePlayerController playerController;

  @override
  void initState() {
    super.initState();

    playerController = YoutubePlayerController(
      initialVideoId: "JK3zztXnDxs",
      flags: const YoutubePlayerFlags(
        mute: true,
        autoPlay: false,
        loop: false,
        forceHD: false,
        isLive: false,
        disableDragSeek: true,
        // hideControls: true,
        useHybridComposition: false,
        endAt: 60,
        controlsVisibleAtStart: true,
        // enableCaption: false,
      ),
    )..addListener(() {
        if (mounted) {
          setState(() {});
        }
      });
  }

  @override
  void deactivate() {
    super.deactivate();
    playerController.pause();
  }

  @override
  void dispose() {
    super.dispose();
    playerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return YoutubePlayerBuilder(
    //     builder: (context, player) {
    var player = YoutubePlayer(
      controller: playerController,
      bottomActions: [
        CurrentPosition(),
      ],
      onEnded: (data) {
        const String nextVideoUtl =
            "https://www.youtube.com/watch?v=hR5JMf_9s6w&t=124s";
        String nextVideo = YoutubePlayer.convertUrlToId(nextVideoUtl)!;
        if (nextVideo == (playerController.value.metaData.videoId)) {
          nextVideo = YoutubePlayer.convertUrlToId(
              "https://www.youtube.com/watch?v=l4cgpaLg_Ls")!;
        }
        playerController.load(nextVideo, endAt: 60);
      },
    );
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            player,
            ElevatedButton(
                onPressed: () {
                  if (playerController.value.isPlaying) {
                    return playerController.pause();
                  }
                  return playerController.play();
                },
                child:
                    Text(playerController.value.isPlaying ? "Pause" : "Play")),
            // ElevatedButton(onPressed: () {}, child: const Text("NExtVideo")),
            Row(
              children: [
                ElevatedButton(
                    onPressed: () {
                      playerController.mute();
                    },
                    child: const Text("Mute")),
                ElevatedButton(
                    onPressed: () {
                      playerController.unMute();
                    },
                    child: const Text("UnMute")),
              ],
            ),
            Text("Title  ${playerController.metadata.title}"),
            Text("Author  ${playerController.metadata.author}"),
            Text("Duration  ${playerController.metadata.duration.inSeconds}"),
            AnimatedButton(
              text: "D",
              onPressed: () {
                deviceStore.changeLoading(true);
                Future.delayed(Duration(milliseconds: 2222), () {
                  deviceStore.changeLoading(false);
                });
              },
              loading: true,
            ),
            Observer(
              builder: (_) {
                return Text(deviceStore.loading.toString());
              },
            ),
            const Spacer(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const AddedVideoLinkPage()));
        },
        child: Icon(
          Icons.add_rounded,
          color: Colors.black.withOpacity(.5),
          size: 50,
        ),
        autofocus: false,
      ),
    );
    // });
  }
}
