// import 'package:watch_and_show/models/channels.dart';

// class ApiService {
//   ApiService._instantiate();

//   static final ApiService instance = ApiService._instantiate();
//   final String _baseUrl = "www.googleapis.com";
//   String _nextPageToken = "";

// ignore_for_file: avoid_print

//   Future<Channel> fetchChannel({required String channelId}) async{
//     Map
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iso_duration_parser/iso_duration_parser.dart';
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
        channelStore.channel!.videos?.addAll(
          {
            video['snippet']['resourceId']['videoId']:
                Video.fromMap(video['snippet'])
          },
        );
        videoIds.add(video["snippet"]['resourceId']['videoId']);
      }
      await fetchVideosDuration(videoIds.join(","));

      Map<String, dynamic> setFirebaseData = {
        "userId": userStore.userData!.userId
      };
      List<Map<String, dynamic>> videos = [];
      for (var element in channelStore.channel!.videos!.values.toList()) {
        Map<String, dynamic> v = element.toMap();
        // setFirebaseData[element.id.toString()]["dateOfUpload"] = DateTime.now();
        v["dateOfUpload"] = DateTime.now();
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

// https://www.googleapis.com/youtube/v3/videos?part=contentDetails,statistics&id=TruIq5IxuiU,-VoFbH8jTzE,RPNDXrAvAMg,gmQmYc9-zcg&key=AIzaSyAywB9VuAeri3ArItxRCYp-M3hh-ldhqtI
// https://www.googleapis.com/youtube/v3/videos?id=9bZkp7q19f0&id=Mfa3u3naQew&part=contentDetails&key=AIzaSyAywB9VuAeri3ArItxRCYp-M3hh-ldhqtI
  Future<void> fetchVideosDuration(String ids) async {
    // Uri uri = Uri.https(
    //   _baseUrl,
    //   '/youtube/v3/videos',
    //   parameters,
    // );
    Uri uri = Uri.parse(
        "https://www.googleapis.com/youtube/v3/videos?part=contentDetails,statistics&id=$ids&maxResults=50&key=$youtubeApiKey");
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    print("videoDetailUri $uri");
    // Get Playlist Videos
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      List<dynamic> videosJson = data['items'];

      // Fetch first eight videos from uploads playlist
      // List<Video> videosDetail = [];
      for (var videoDeatil in videosJson) {
        var videoDuration = Duration(
            seconds:
                IsoDuration.parse(videoDeatil["contentDetails"]["duration"])
                    .toSeconds()
                    .toInt());

        channelStore.channel!.videos![videoDeatil["id"]]!.duration =
            videoDuration;

        channelStore.channel!.videos![videoDeatil["id"]]!.viewCount =
            (int.tryParse(videoDeatil["statistics"]["viewCount"].toString()));
        channelStore.channel!.videos![videoDeatil["id"]]!.likeCount =
            (int.tryParse(videoDeatil["statistics"]["likeCount"].toString()));
        channelStore.channel!.videos![videoDeatil["id"]]!.favoriteCount =
            (int.tryParse(
                videoDeatil["statistics"]["favoriteCount"].toString()));
        channelStore.channel!.videos![videoDeatil["id"]]!.commentCount =
            (int.tryParse(
                videoDeatil["statistics"]["commentCount"].toString()));
        // channelStore.channel!.videos?.addAll(videoDeatil["duration"]);
      }
      // videosJson.forEach(
      //   (json) => videosDetail.add(
      //     Video.fromMap(json['contentDetails']),
      //   ),
      // );

      // return videos;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }
}
