import 'package:flutter/material.dart';
import 'package:watch_and_show/global.dart';
import 'package:watch_and_show/models/published_video.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'package:watch_and_show/core/custom_appbar.dart';

class WatchViewPage extends StatefulWidget {
  const WatchViewPage({
    Key? key,
    required this.video,
  }) : super(key: key);
  final PublishedVideo video;

  @override
  State<WatchViewPage> createState() => _WatchViewPageState();
}

class _WatchViewPageState extends State<WatchViewPage> {
  late YoutubePlayerController playerController;
  late final PublishedVideo video;
  @override
  void initState() {
    video = widget.video;

    super.initState();

    playerController = YoutubePlayerController(
      initialVideoId: video.videoId!,
      flags: YoutubePlayerFlags(
        mute: true,
        autoPlay: true,
        loop: false,
        forceHD: false,
        isLive: false,
        disableDragSeek: true,
        // hideControls: true,
        useHybridComposition: false,
        endAt: video.viewDuration,
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
        dbServices.publishedVideoDb
            .doc(video.docId)
            .update({"watcher": (video.watcher ?? 0) + 1});
      },
    );
    return Scaffold(
      appBar: customAppBar(context),
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
            const Spacer(),
          ],
        ),
      ),
    );
    // });
  }
}
