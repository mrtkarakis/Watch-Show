import 'package:mobx/mobx.dart';
import 'package:watch_and_show/global.dart';
import 'package:watch_and_show/models/published_video.dart';
part 'videos_store.g.dart';

class VideosStore = _VideosStoreBase with _$VideosStore;

abstract class _VideosStoreBase with Store {
  List<PublishedVideo> videos = [];

  @action
  void getVideos() {
    List<String> where = [userStore.user.uid];
    dbServices.publishedVideoDb
        .where("watcher", isLessThan: where)
        .get()
        .then((value) {
      videos.clear();
      for (var element in value.docs) {
        Map<String, dynamic> data = element.data();
        videos.add(PublishedVideo.fromFirebase(data));
      }
      print(videos);
    });
  }
}
