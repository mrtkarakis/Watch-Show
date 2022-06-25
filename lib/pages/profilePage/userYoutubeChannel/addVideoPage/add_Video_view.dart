import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:watch_and_show/global.dart';
import 'package:watch_and_show/models/published_video.dart';
import 'package:watch_and_show/models/video.dart';
import 'package:watch_and_show/pages/profilePage/userYoutubeChannel/user_youtube_channel_widgets.dart';

class AddVideoPage extends StatefulWidget {
  AddVideoPage({Key? key}) : super(key: key);

  @override
  State<AddVideoPage> createState() => _AddVideoPageState();
}

class _AddVideoPageState extends State<AddVideoPage> {
  final TextEditingController videoLinkTextEditingController =
      TextEditingController();

  Video? video;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const Spacer(),
              Text(
                "Lütfen paylaşmak istedğiniz videonun linkini giriniz.",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              TextFormField(
                  controller: videoLinkTextEditingController,
                  decoration: InputDecoration(
                    label: const Text("Video Link"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  textInputAction: TextInputAction.done),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: deviceStore.width / 3,
                    height: deviceStore.width / 5,
                    child: ElevatedButton(
                        onPressed: () async {
                          bool hasCopyText = await Clipboard.hasStrings();
                          print("hasCopyText $hasCopyText ");
                          if (hasCopyText) {
                            ClipboardData? copyText =
                                await Clipboard.getData('text/plain');
                            print("copyText $copyText ");
                            videoLinkTextEditingController.text =
                                copyText!.text!.trim();
                          }
                        },
                        child: const Text(
                          "Son Kopyalanınan Metni Kullan",
                          style: TextStyle(color: Colors.black87),
                        )),
                  ),
                  SizedBox(
                    height: deviceStore.width / 5,
                    width: deviceStore.width / 3,
                    child: ElevatedButton(
                        onPressed: () async {
                          Uri videoLinkUri = Uri.parse(
                              videoLinkTextEditingController.text.trim());
                          String id =
                              videoLinkUri.queryParameters["v"] as String;
                          Map<String, Video?>? fetchVideo =
                              await apiService.fetchVideos(id);
                          print("keo $fetchVideo");
                          video = fetchVideo.values.first;
                          setState(() {});
                        },
                        child: Text("Get Video Data")),
                  )
                ],
              ),
              video != null
                  ? Text(video!.snippet!.thumbnails!.medium!.url.toString())
                  : const SizedBox(),
              const Spacer(flex: 4),
              ElevatedButton(
                  onPressed: () async {
                    deviceStore.changeLoading(true);
                    bool hasVideo =
                        await checkHasVideo(video!.id ?? "") as bool;
                    if (!hasVideo) {
                      final String docId = dbServices.publishedVideoDb.doc().id;
                      PublishedVideo publishedVideo =
                          PublishedVideo.fromVideoData(
                              docId: docId, video: video!);

                      await dbServices.publishedVideoDb
                          .doc(docId)
                          .set(publishedVideo.toMap());
                      deviceStore.changeLoading(false);
                      Navigator.pop(context);
                    }
                  },
                  child: Text("Publish"))
            ],
          ),
        ),
      ),
    );
  }
}
