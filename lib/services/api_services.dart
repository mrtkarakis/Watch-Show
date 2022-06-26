// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:watch_and_show/global.dart';
import 'package:watch_and_show/models/channel.dart';
import 'package:watch_and_show/models/video.dart';
import 'package:watch_and_show/utilities/keys.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

Map<String, dynamic> videosData = {};

class APIService {
  APIService._instantiate();

  static final APIService instance = APIService._instantiate();

  final String _baseUrl = 'www.googleapis.com';

  Future<void> fetchChannel({required String channelId}) async {
    Map<String, String> parameters = {
      'part': 'snippet, contentDetails, statistics',
      'id': channelId,
      'key': youtubeApiKey,
      'type': "channel"
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/channels',
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    print("channelUri  $uri  ");
    // Get Channel
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body)['items'][0];
      channelStore.channel = Channel.fromMap(data);

      // Fetch first batch of videos from uploads playlist
      // channelStore.channel!.videos =
      await fetchVideosFromPlaylist(
        playlistId: channelStore.channel!.uploadPlaylistId!,
      );
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }

  Future<void> fetchVideosFromPlaylist({required String playlistId}) async {
    Map<String, String> parameters = {
      'part': 'snippet',
      'playlistId': playlistId,
      'maxResults': '50',
      'key': youtubeApiKey,
      "order": "date"
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/playlistItems',
      parameters,
    );
    print("videoUri $uri ");
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    // Get Playlist Videos
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      List<dynamic> videosJson = data['items'];

      // Fetch first eight videos from uploads playlist
      // List<Video> videos = [];
      channelStore.channel!.videos = {};
      List<String> videoIds = [];
      for (var video in videosJson) {
        final String videoId = video['snippet']['resourceId']['videoId'];
        channelStore.channel!.videos?.addAll(
          {
            videoId: Video.fromJson(video),
          },
        );

        videoIds.add(videoId);
      }
      await fetchVideos(videoIds.join(","));

      Map<String, dynamic> setFirebaseData = {
        "userId": userStore.userData!.userId
      };
      List<Map<String, dynamic>> videos = [];
      for (var element in channelStore.channel!.videos!.values.toList()) {
        print("element ${element.toJson()} ");
        Map<String, dynamic> v = element.toJson();
        // v["dateOfUpload"] = DateTime.now();
        Future.delayed(const Duration(microseconds: 100));
        videos.add(v);
      }

      setFirebaseData.addAll({"videos": videos});

      dbServices.channelsDb
          .doc(channelStore.channel?.id)
          .set(channelStore.channel!.toMap(), SetOptions(merge: true));
      dbServices.videosDb.doc(channelStore.channel?.id).set(
            setFirebaseData,
            SetOptions(
              merge: true,
            ),
          );
      // return videos;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }

  // Future<void> fetchVideosDuration(String ids) async {
  //   Map<String, String> parameters = {
  //     'part': 'contentDetails, statistics, snippet',
  //     'id': ids,
  //     'maxResults': '50',
  //     'key': youtubeApiKey,
  //   };
  //   Uri uri = Uri.https(
  //     _baseUrl,
  //     '/youtube/v3/videos',
  //     parameters,
  //   );
  //   Map<String, String> headers = {
  //     HttpHeaders.contentTypeHeader: 'application/json',
  //   };

  //   print("videoDetailUri $uri");
  //   // Get Playlist Videos
  //   var response = await http.get(uri, headers: headers);
  //   if (response.statusCode == 200) {
  //     var data = json.decode(response.body);

  //     List<dynamic> videosJson = data['items'];

  //     // Fetch first eight videos from uploads playlist
  //     // List<Video> videosDetail = [];
  //     for (var videoDeatil in videosJson) {
  //       var videoDuration = Duration(
  //           seconds:
  //               IsoDuration.parse(videoDeatil["contentDetails"]["duration"])
  //                   .toSeconds()
  //                   .toInt());

  //       channelStore.channel!.videos![videoDeatil["id"]]!.duration =
  //           videoDuration;

  //       channelStore.channel!.videos![videoDeatil["id"]]!.viewCount =
  //           (int.tryParse(videoDeatil["statistics"]["viewCount"].toString()));
  //       channelStore.channel!.videos![videoDeatil["id"]]!.likeCount =
  //           (int.tryParse(videoDeatil["statistics"]["likeCount"].toString()));
  //       channelStore.channel!.videos![videoDeatil["id"]]!.favoriteCount =
  //           (int.tryParse(
  //               videoDeatil["statistics"]["favoriteCount"].toString()));
  //       channelStore.channel!.videos![videoDeatil["id"]]!.commentCount =
  //           (int.tryParse(
  //               videoDeatil["statistics"]["commentCount"].toString()));
  //     }
  //   } else {
  //     throw json.decode(response.body)['error']['message'];
  //   }
  // }

  Future<Map<String, Video?>> fetchVideos(String ids) async {
    Map<String, Video?> result = {};
    Map<String, String> parameters = {
      'part': 'contentDetails, statistics, snippet',
      'id': ids,
      'maxResults': '50',
      'key': youtubeApiKey,
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/videos',
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    print("videoDetailUri $uri");
    // Get Video
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      List<dynamic> videosJson = data['items'];
      print("videoJson $videosJson ");

      // Fetch first eight videos from uploads playlist
      // List<Video> videosDetail = [];
      for (var videoDeatil in videosJson) {
        Video video = Video.fromJson(videoDeatil);
        final String videoId = videoDeatil["id"];

        result[videoId] = video;
      }
    } else {
      throw json.decode(response.body)['error']['message'];
    }
    return result;
  }
}
