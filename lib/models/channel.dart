import 'package:watch_and_show/global.dart';

import 'video.dart';

class Channel {
  final String? id;
  String? userId = userStore.userData!.userId;
  final String? title;
  final String? profilePictureUrl;
  final String? subscriberCount;
  final String? videoCount;
  final String? viewCount;
  final String? uploadPlaylistId;
  final String? customUrl;
  final String? publishedAt;

  Map<String, Video>? videos;

  Channel({
    this.id,
    this.title,
    this.profilePictureUrl,
    this.subscriberCount,
    this.videoCount,
    this.uploadPlaylistId,
    this.videos,
    this.customUrl,
    this.publishedAt,
    this.viewCount,
  });

  factory Channel.fromMap(Map<String, dynamic> map) {
    return Channel(
      id: map['id'],
      title: map['snippet']['title'],
      profilePictureUrl: map['snippet']['thumbnails']['default']['url'],
      subscriberCount: map['statistics']['subscriberCount'],
      videoCount: map['statistics']['videoCount'],
      uploadPlaylistId: map['contentDetails']['relatedPlaylists']['uploads'],
      customUrl: map['snippet']['customUrl'],
      publishedAt: map['snippet']['publishedAt'],
      viewCount: map['statistics']['viewCount'],
    );
  }

  factory Channel.fromFirebase(Map<String, dynamic> map) {
    return Channel(
      id: map['id'],
      title: map['title'],
      profilePictureUrl: map['profilePictureUrl'],
      subscriberCount: map['subscriberCount'],
      videoCount: map['videoCount'],
      uploadPlaylistId: map['uploadPlaylistId'],
      customUrl: map['customUrl'],
      publishedAt: map['publishedAt'],
      viewCount: map['viewCount'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'profilePictureUrl': profilePictureUrl,
      'subscriberCount': subscriberCount,
      'videoCount': videoCount,
      "uploadPlaylistId": uploadPlaylistId,
      "customUrl": customUrl,
      "publishedAt": publishedAt,
      "viewCount": viewCount,
    };
  }
}
