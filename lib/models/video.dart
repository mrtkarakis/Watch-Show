import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:watch_and_show/global.dart';
import 'package:intl/intl.dart';

class Video {
  final String? id;
  String? userId = userStore.userData!.userId;
  final String? title;
  final String? thumbnailUrl;
  final String? channelTitle;
  final DateTime? publishedAt;
  final String? videoOwnerChannelId;
  final DateTime? dateOfUpload;
  int? viewCount;
  Duration? duration;
  int? likeCount;
  int? favoriteCount;
  int? commentCount;

  Video({
    this.id,
    this.title,
    this.thumbnailUrl,
    this.channelTitle,
    this.duration,
    this.publishedAt,
    this.videoOwnerChannelId,
    this.dateOfUpload,
    this.viewCount,
    this.likeCount,
    this.favoriteCount,
    this.commentCount,
  });

  factory Video.fromMap(Map<String, dynamic> snippet) {
    DateFormat publishedDateFormat = DateFormat("yyyy-MM-ddThh:mm:ssZ");
    DateTime publishDate =
        publishedDateFormat.parse(snippet['publishedAt'].toString());

    // DateFormat videoDurationDateFormat = DateFormat("PTmmMsS");
    // DateTime videoDuration =
    //     videoDurationDateFormat.parse(snippet['duration'].toString());
    return Video(
      id: snippet['resourceId']['videoId'],
      title: snippet['title'],
      thumbnailUrl: snippet['thumbnails']['high']['url'],
      channelTitle: snippet['channelTitle'],
      // duration: videoDuration,
      publishedAt: publishDate,
      videoOwnerChannelId: snippet['videoOwnerChannelId'].toString(),
      // viewCount: snippet["statistics"]['viewCount']?.toInt(),
      // likeCount: snippet["statistics"]['likeCount']?.toInt(),
      // favoriteCount: snippet["statistics"]['favoriteCount']?.toInt(),
      // commentCount: snippet["statistics"]['commentCount']?.toInt(),
    );
  }

  factory Video.fromFirebase(Map<String, dynamic> doc) {
    return Video(
      id: doc['id'],
      title: doc['title'],
      thumbnailUrl: doc['thumbnailUrl'],
      channelTitle: doc['channelTitle'],
      duration: Duration(seconds: doc['duration'] as int),
      publishedAt: DateTime.fromMillisecondsSinceEpoch(
          doc['publishedAt'].seconds * 1000),
      videoOwnerChannelId: doc['videoOwnerChannelId'].toString(),
      dateOfUpload: DateTime.fromMillisecondsSinceEpoch(
          doc['dateOfUpload'].seconds * 1000),
      viewCount: doc['viewCount'],
      likeCount: doc['likeCount'],
      favoriteCount: doc['favoriteCount'],
      commentCount: doc['commentCount'],
    );
  }

  Video copyWith({
    String? id,
    String? title,
    String? thumbnailUrl,
    String? channelTitle,
    Duration? duration,
    DateTime? publishedAt,
    String? videoOwnerChannelId,
  }) {
    return Video(
      id: id ?? this.id,
      title: title ?? this.title,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      channelTitle: channelTitle ?? this.channelTitle,
      duration: duration ?? this.duration,
      publishedAt: publishedAt ?? this.publishedAt,
      videoOwnerChannelId: videoOwnerChannelId ?? this.videoOwnerChannelId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'thumbnailUrl': thumbnailUrl,
      'channelTitle': channelTitle,
      'duration': duration?.inSeconds,
      "publishedAt": publishedAt,
      "videoOwnerChannelId": videoOwnerChannelId,
      "dateOfUpload": dateOfUpload,
      "viewCount": viewCount,
      "likeCount": likeCount,
      "favoriteCount": favoriteCount,
      "commentCount": commentCount,
    };
  }

  String toJson() => json.encode(toMap());

  factory Video.fromJson(String source) => Video.fromMap(json.decode(source));
}
