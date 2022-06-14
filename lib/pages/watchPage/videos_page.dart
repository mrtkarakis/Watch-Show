// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:watch_and_show/core/animated_button.dart';
import 'package:watch_and_show/global.dart';
import 'package:watch_and_show/models/published_video.dart';
import 'package:watch_and_show/models/video.dart';
import 'package:watch_and_show/pages/watchPage/video_detail_box.dart';
import 'package:watch_and_show/shared/added_video_link.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideosPage extends StatefulWidget {
  const VideosPage({Key? key}) : super(key: key);

  @override
  State<VideosPage> createState() => _VideosPageState();
}

class _VideosPageState extends State<VideosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder(
                  future: dbServices.publishedVideoDb.get(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    List videos = [];
                    if (snapshot.hasData) {
                      videos = snapshot.data.docs;
                    }
                    return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: videos.length,
                        itemBuilder: (BuildContext context, int index) {
                          PublishedVideo video =
                              PublishedVideo.fromFirebase(videos[index].data());

                          return VideoDetailBox(video: video);
                        });
                  })
            ],
          ),
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
