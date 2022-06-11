import 'package:flutter/material.dart';
import 'package:watch_and_show/core/custom_appbar.dart';
import 'package:watch_and_show/extensions/duration.dart';
import 'package:watch_and_show/global.dart';
import 'package:watch_and_show/models/video.dart';
import 'package:watch_and_show/pages/profilePage/userYoutubeChannel/user_youtube_channel_widgets.dart';

class UserYouTubeChannelPage extends StatefulWidget {
  const UserYouTubeChannelPage({Key? key}) : super(key: key);

  @override
  State<UserYouTubeChannelPage> createState() => _UserYouTubeChannelPageState();
}

class _UserYouTubeChannelPageState extends State<UserYouTubeChannelPage> {
  final UserYoutubeChannelWidgets _userYoutubeChannelWidgets =
      UserYoutubeChannelWidgets();
  // Channel? _channel;
  bool _isLoading = false;

  late String lastCopyData;
  @override
  void initState() {
    super.initState();
  }

  _buildProfileInfo() {
    return Container(
      margin: const EdgeInsets.all(20.0),
      padding: const EdgeInsets.all(20.0),
      height: 100.0,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 1),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 35.0,
            backgroundImage:
                NetworkImage(channelStore.channel!.profilePictureUrl!),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  channelStore.channel!.title!,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${channelStore.channel!.subscriberCount} subscribers',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _buildVideo(Video video) {
    return GestureDetector(
      // onTap: () => Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (_) => VideoScreen(id: video.id),
      //   ),
      // ),
      child: TextButton(
        onPressed: () {
          _userYoutubeChannelWidgets.videoDetail(
            context: context,
            video: video,
          );
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
          padding: const EdgeInsets.all(10.0),
          height: 140.0,
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 1),
                blurRadius: 6.0,
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Hero(
                tag: video.thumbnailUrl!,
                child: Image(
                  width: 150.0,
                  image: NetworkImage(video.thumbnailUrl!),
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    children: [
                      Text(
                        video.title!,
                        style: const TextStyle(
                          fontSize: 12.0,
                        ),
                        maxLines: 2,
                      ),
                      Align(
                          alignment: Alignment.centerRight,
                          child: Text(video.duration!.toText())),
                      FittedBox(child: Text(video.publishedAt.toString())),
                      FittedBox(child: Text(video.viewCount.toString())),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _loadMoreVideos() async {
    _isLoading = true;
    // List<Video> moreVideos =
    //  await APIService.instance.fetchVideosFromPlaylist(
    //     playlistId: channelStore.channel!.uploadPlaylistId!);
    // List<Video> allVideos = channelStore.channel!.videos!..addAll(moreVideos);
    setState(() {
      // channelStore.channel!.videos = allVideos;
    });
    _isLoading = false;
  }

  TextEditingController youtubeVideoLinkTextEditingController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    int itemCount;
    try {
      itemCount = 1 + channelStore.channel!.videos!.length;
    } catch (e) {
      itemCount = 1;
    }
    return Scaffold(
      appBar: customAppBar(context),
      body: channelStore.channel != null
          ? NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollDetails) {
                if (!_isLoading &&
                    channelStore.channel!.videos!.length !=
                        int.parse(channelStore.channel!.videoCount!) &&
                    scrollDetails.metrics.pixels ==
                        scrollDetails.metrics.maxScrollExtent) {
                  _loadMoreVideos();
                }
                return false;
              },
              child: ListView.builder(
                itemCount: itemCount,
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return _buildProfileInfo();
                  }
                  Video video =
                      channelStore.channel!.videos!.values.toList()[index - 1];
                  return _buildVideo(video);
                },
              ),
            )
          : Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).primaryColor, // Red
                ),
              ),
            ),
    );
  }

  Padding formField({
    required TextEditingController textEditingController,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: textEditingController,
            decoration: InputDecoration(
              label: const Text("Youtube Video Link"),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
            textInputAction: TextInputAction.done,
          ),
        ],
      ),
    );
  }
}
