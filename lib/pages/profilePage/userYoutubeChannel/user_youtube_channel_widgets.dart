import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:watch_and_show/core/animated_button.dart';
import 'package:watch_and_show/core/video_thumbnail.dart';
import 'package:watch_and_show/extensions/duration.dart';
import 'package:watch_and_show/extensions/string.dart';
import 'package:watch_and_show/global.dart';
import 'package:watch_and_show/models/published_video.dart';
import 'package:watch_and_show/models/video.dart';
import 'package:watch_and_show/pages/profilePage/userYoutubeChannel/set_watch_video_duration.dart';
import 'package:watch_and_show/pages/profilePage/userYoutubeChannel/set_watch_video_viewer.dart';

class UserYoutubeChannelWidgets {
  videoDetail({
    required BuildContext context,
    required Video video,
  }) {
    Widget videoThumbnail() {
      return ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        child: Hero(
            tag: video.thumbnailUrl!,
            child: VideoThumbnail(
              src: video.thumbnailUrl ?? "",
              width: double.infinity,
            )),
      );
    }

    Widget videoViewCounter() {
      return Row(
        children: [
          const Icon(Icons.remove_red_eye_outlined),
          const SizedBox(width: 6),
          VideoDetailWidgets(video: video).videoViewCount("${video.viewCount}"),
        ],
      );
    }

    Widget videoDuration() {
      return Row(
        children: [
          const Icon(Icons.timelapse_outlined),
          const SizedBox(width: 6),
          Align(
              alignment: Alignment.centerRight,
              child: Text(
                video.duration!.toText(),
                style:
                    const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              )),
        ],
      );
    }

    Widget videoPublished() {
      return Row(
        children: [
          const Icon(Icons.publish_outlined),
          const SizedBox(width: 3),
          Align(
              alignment: Alignment.centerRight,
              child:
                  VideoDetailWidgets(video: video).viedeoPublishedDate(video)),
        ],
      );
    }

    Widget publishedVideoButton({required Video video}) {
      return AnimatedButton(
        text: "Publish",
        onPressed: () async {
          bool hasVideo = await checkHasVideo(video.id ?? "") as bool;
          if (!hasVideo) {
            final String docId = dbServices.publishedVideoDb.doc().id;
            PublishedVideo publishedVideo =
                PublishedVideo.fromVideoData(docId: docId, video: video);

            await dbServices.publishedVideoDb
                .doc(docId)
                .set(publishedVideo.toMap());
            Navigator.pop(context);
          }
        },
      );
    }

    showModalBottomSheet(
        isScrollControlled: true,
        constraints: BoxConstraints(
            maxHeight: deviceStore.height - 80, minWidth: double.infinity),
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (_) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                videoThumbnail(),
                const SizedBox(height: 20),
                VideoDetailWidgets(video: video).videoTitle(),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    videoDuration(),
                    const SizedBox(width: 12),
                    videoViewCounter(),
                    const SizedBox(width: 12),
                    videoPublished(),
                  ],
                ),
                const Spacer(flex: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SetWatchVideoDuration(
                      videoDurationSecond: video.duration!.inSeconds,
                    ),
                    const SetWatchVideoViewer()
                  ],
                ),
                const Spacer(flex: 1),
                totalCreditAmount(),
                const SizedBox(height: 12),
                publishedVideoButton(video: video),
                const Spacer(flex: 2),
              ],
            ),
          );
        });
  }
}

Widget totalCreditAmount() {
  return Observer(builder: (_) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        "Total Amount " + publishedVideoStore.totalCreditAmount.toString(),
        style: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.w700, color: Colors.orange),
      ),
    );
  });
}

Future<bool?> checkHasVideo(String videoId) async {
  bool? result;
  await dbServices.publishedVideoDb
      .where("videoId", isEqualTo: videoId)
      .limit(1)
      .get()
      .then((value) {
    result = value.docs.isNotEmpty;
  });
  return result;
}

class VideoDetailWidgets {
  final Video? video;
  VideoDetailWidgets({
    required this.video,
  });

  Text viedeoPublishedDate(Video video) {
    return Text(
      "${video.publishedAt?.day.toString().withZero()}/${video.publishedAt?.month.toString().withZero()}/${video.publishedAt?.year.toString().withZero()}",
      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
    );
  }

  Widget videoTitle() {
    return Text(
      "${video?.title} ",
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      maxLines: 2,
    );
  }

  Text videoViewCount(String? videoViewCount) {
    return Text(
      "${video?.viewCount}",
      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
    );
  }
}
