// Map<String, dynamic> publishedVideo = {
//           "docId": docId,
//           "videoName": video.title,
//           "videoPublishedAt": video.publishedAt,
//           "videoCommentCount": video.commentCount,
//           "videoDuration": video.duration?.inSeconds,
//           "videoId": video.id,
//           "videoViewCount": video.viewCount,
//           "videoLikeCount": video.likeCount,
//           "videoThumbnailUrl": video.thumbnailUrl,
//           "videoOwnerChannelId": video.videoOwnerChannelId,
//         };

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'video.dart';

class PublishedVideo {
  final String? docId;
  final String? videoName;
  final DateTime? videoPublishedAt;
  final int? videoCommentCount;
  final int? videoDuration;
  final String? videoId;
  final int? videoViewCount;
  final int? videoLikeCount;
  final String? videoThumbnailUrl;
  final String? videoOwnerChannelId;
  PublishedVideo({
    this.docId,
    this.videoName,
    this.videoPublishedAt,
    this.videoCommentCount,
    this.videoDuration,
    this.videoId,
    this.videoViewCount,
    this.videoLikeCount,
    this.videoThumbnailUrl,
    this.videoOwnerChannelId,
  });

  PublishedVideo copyWith({
    String? docId,
    String? videoName,
    DateTime? videoPublishedAt,
    int? videoCommentCount,
    int? videoDuration,
    String? videoId,
    int? videoViewCount,
    int? videoLikeCount,
    String? videoThumbnailUrl,
    String? videoOwnerChannelId,
  }) {
    return PublishedVideo(
      docId: docId ?? this.docId,
      videoName: videoName ?? this.videoName,
      videoPublishedAt: videoPublishedAt ?? this.videoPublishedAt,
      videoCommentCount: videoCommentCount ?? this.videoCommentCount,
      videoDuration: videoDuration ?? this.videoDuration,
      videoId: videoId ?? this.videoId,
      videoViewCount: videoViewCount ?? this.videoViewCount,
      videoLikeCount: videoLikeCount ?? this.videoLikeCount,
      videoThumbnailUrl: videoThumbnailUrl ?? this.videoThumbnailUrl,
      videoOwnerChannelId: videoOwnerChannelId ?? this.videoOwnerChannelId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'docId': docId,
      'videoName': videoName,
      'videoPublishedAt': videoPublishedAt?.millisecondsSinceEpoch,
      'videoCommentCount': videoCommentCount,
      'videoDuration': videoDuration,
      'videoId': videoId,
      'videoViewCount': videoViewCount,
      'videoLikeCount': videoLikeCount,
      'videoThumbnailUrl': videoThumbnailUrl,
      'videoOwnerChannelId': videoOwnerChannelId,
    };
  }

  factory PublishedVideo.fromVideoData(
      {required String docId, required Video video}) {
    return PublishedVideo(
      docId: docId,
      videoName: video.title,
      videoPublishedAt: video.publishedAt,
      videoCommentCount: video.commentCount,
      videoDuration: video.duration?.inSeconds,
      videoId: video.id,
      videoViewCount: video.viewCount,
      videoLikeCount: video.likeCount,
      videoThumbnailUrl: video.thumbnailUrl,
      videoOwnerChannelId: video.videoOwnerChannelId,
    );
  }

  factory PublishedVideo.fromFirebase(Map<String, dynamic> map) {
    return PublishedVideo(
      docId: map['docId'],
      videoName: map['videoName'],
      videoPublishedAt: map['videoPublishedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['videoPublishedAt'])
          : null,
      videoCommentCount: map['videoCommentCount']?.toInt(),
      videoDuration: map['videoDuration']?.toInt(),
      videoId: map['videoId'],
      videoViewCount: map['videoViewCount']?.toInt(),
      videoLikeCount: map['videoLikeCount']?.toInt(),
      videoThumbnailUrl: map['videoThumbnailUrl'],
      videoOwnerChannelId: map['videoOwnerChannelId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PublishedVideo.fromJson(String source) =>
      PublishedVideo.fromFirebase(json.decode(source));

  @override
  String toString() {
    return 'PublishedVideo(docId: $docId, videoName: $videoName, videoPublishedAt: $videoPublishedAt, videoCommentCount: $videoCommentCount, videoDuration: $videoDuration, videoId: $videoId, videoViewCount: $videoViewCount, videoLikeCount: $videoLikeCount, videoThumbnailUrl: $videoThumbnailUrl, videoOwnerChannelId: $videoOwnerChannelId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PublishedVideo &&
        other.docId == docId &&
        other.videoName == videoName &&
        other.videoPublishedAt == videoPublishedAt &&
        other.videoCommentCount == videoCommentCount &&
        other.videoDuration == videoDuration &&
        other.videoId == videoId &&
        other.videoViewCount == videoViewCount &&
        other.videoLikeCount == videoLikeCount &&
        other.videoThumbnailUrl == videoThumbnailUrl &&
        other.videoOwnerChannelId == videoOwnerChannelId;
  }

  @override
  int get hashCode {
    return docId.hashCode ^
        videoName.hashCode ^
        videoPublishedAt.hashCode ^
        videoCommentCount.hashCode ^
        videoDuration.hashCode ^
        videoId.hashCode ^
        videoViewCount.hashCode ^
        videoLikeCount.hashCode ^
        videoThumbnailUrl.hashCode ^
        videoOwnerChannelId.hashCode;
  }
}
