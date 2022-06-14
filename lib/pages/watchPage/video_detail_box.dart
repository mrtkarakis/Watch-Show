import 'package:flutter/material.dart';
import 'package:watch_and_show/core/video_thumbnail.dart';
import 'package:watch_and_show/global.dart';

import 'package:watch_and_show/models/published_video.dart';
import 'package:watch_and_show/pages/watchPage/watch_view.dart';

class VideoDetailBox extends StatelessWidget {
  const VideoDetailBox({
    Key? key,
    required this.video,
  }) : super(key: key);
  final PublishedVideo video;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VideoThumbnail(
                src: video.videoThumbnailUrl,
                width: deviceStore.width / 2.5,
              ),
              const SizedBox(width: 4),
              SizedBox(
                width: deviceStore.width / 2.2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${video.videoName}",
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text("duration ${video.viewDuration}"),
                        const Spacer(),
                        Text("Token ${(video.viewDuration ?? 0) * 2}"),
                      ],
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => WatchViewPage(
                                        video: video,
                                      )));
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Colors.green.shade300),
                        child: const Text(
                          "Watch & Learn",
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
