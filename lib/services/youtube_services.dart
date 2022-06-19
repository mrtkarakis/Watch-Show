import 'package:watch_and_show/global.dart';
import 'package:watch_and_show/models/channel.dart';
import 'package:watch_and_show/models/video.dart';

import 'api_services.dart';

class YoutubeService {
  YoutubeService._instantiate();

  static final YoutubeService instance = YoutubeService._instantiate();

  initChannel() async {
    await dbServices.channelsDb
        .where("userId", isEqualTo: userStore.userData!.userId)
        .limit(1)
        .get()
        .then((value) async {
      if (value.size == 0) {
        channelStore.hasDataFirebase.channels = false;
      } else {
        channelStore.hasDataFirebase.channels = true;

        channelStore.channel = Channel.fromFirebase(value.docs.first.data());
      }
    });

    if (channelStore.hasDataFirebase.channels) {
      await dbServices.videosDb
          .where("userId", isEqualTo: userStore.userData!.userId)
          .limit(1)
          .get()
          .then((value) async {
        if (value.size == 0) {
          await APIService.instance.fetchVideosFromPlaylist(
            playlistId: channelStore.channel!.uploadPlaylistId!,
          );
        } else {
          Map<String, Video> videos = {};

          List dataVideos = value.docs.first.data()["videos"];
          for (var element in dataVideos) {
            videos.addAll(
                {element["id"].toString(): Video.fromFirebase(element)});
          }

          channelStore.channel!.videos = videos;
        }
      });
    }
  }
}
