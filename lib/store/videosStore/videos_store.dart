import 'package:mobx/mobx.dart';
import 'package:watch_and_show/global.dart';
import 'package:watch_and_show/models/published_video.dart';
import 'package:watch_and_show/models/video.dart';
part 'videos_store.g.dart';

class VideosStore = _VideosStoreBase with _$VideosStore;

abstract class _VideosStoreBase with Store {
  List<PublishedVideo> videos = [];

  @action
  void getVideos() {
    developerLog("call getVideos", name: "getVideos");
    List<String> where = [userStore.user.uid];
    dbServices.publishedVideoDb
        .where("watcher", isLessThan: where)
        .limit(40)
        .get()
        .then((value) {
      videos.clear();
      for (var element in value.docs) {
        Map<String, dynamic> data = element.data();
        PublishedVideo publishedVideo = PublishedVideo.fromFirebase(data);
        if (publishedVideo.publisherUserId != userStore.user.uid) {
          videos.add(publishedVideo);
        }
      }
      developerLog("Videos Length ${videos.length}");
    });
  }
}
