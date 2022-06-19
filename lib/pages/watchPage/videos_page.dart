// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:watch_and_show/global.dart';
import 'package:watch_and_show/models/published_video.dart';
import 'package:watch_and_show/pages/watchPage/video_detail_box.dart';

class VideosPage extends StatefulWidget {
  const VideosPage({Key? key}) : super(key: key);

  @override
  State<VideosPage> createState() => _VideosPageState();
}

class _VideosPageState extends State<VideosPage> {
  Timer? checkVideoTimer;

  void checkVideos() {
    checkVideoTimer =
        Timer.periodic(const Duration(milliseconds: 800), (timer) {
      developerLog("videosPageTimer ${timer.tick}");
      if (videosStore.videos.isEmpty) {
        videosStore.getVideos();
      } else {
        setState(() {});
        cancelCheckVideo();
      }
    });
  }

  void cancelCheckVideo() => checkVideoTimer?.cancel();
  @override
  void initState() {
    checkVideos();
    super.initState();
  }

  @override
  void dispose() {
    cancelCheckVideo();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: videosStore.videos.isEmpty
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: videosStore.videos.length,
                    itemBuilder: (BuildContext context, int index) {
                      PublishedVideo video = videosStore.videos[index];

                      return VideoDetailBox(video: video);
                    }),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
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
