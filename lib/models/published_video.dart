import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:iso_duration_parser/iso_duration_parser.dart';
import 'package:watch_and_show/global.dart';

import 'video.dart';

class PublishedVideo {
  final String? docId;
  final String? publisherUserId;
  final String? videoName;
  final DateTime? videoPublishedAt;
  final DateTime? addTime;
  final int? videoCommentCount;
  final int? videoDuration;
  final int? viewDuration;
  final int? viewer;
  final int? amount;
  final List<dynamic>? watcher;
  final String? videoId;
  final int? videoViewCount;
  final int? videoLikeCount;
  final String? videoThumbnailUrl;
  final String? videoOwnerChannelId;
  PublishedVideo({
    this.docId,
    this.publisherUserId,
    this.videoName,
    this.videoPublishedAt,
    this.addTime,
    this.videoCommentCount,
    this.videoDuration,
    this.viewDuration,
    this.viewer,
    this.amount = 0,
    this.watcher,
    this.videoId,
    this.videoViewCount,
    this.videoLikeCount,
    this.videoThumbnailUrl,
    this.videoOwnerChannelId,
  });

  PublishedVideo copyWith({
    String? docId,
    String? publisherUserId,
    String? videoName,
    DateTime? videoPublishedAt,
    DateTime? addTime,
    int? videoCommentCount,
    int? videoDuration,
    int? viewDuration,
    int? viewer,
    int? amount,
    List<dynamic>? watcher,
    String? videoId,
    int? videoViewCount,
    int? videoLikeCount,
    String? videoThumbnailUrl,
    String? videoOwnerChannelId,
  }) {
    return PublishedVideo(
      docId: docId ?? this.docId,
      publisherUserId: publisherUserId ?? this.publisherUserId,
      videoName: videoName ?? this.videoName,
      videoPublishedAt: videoPublishedAt ?? this.videoPublishedAt,
      addTime: addTime ?? this.addTime,
      videoCommentCount: videoCommentCount ?? this.videoCommentCount,
      videoDuration: videoDuration ?? this.videoDuration,
      viewDuration: viewDuration ?? this.viewDuration,
      viewer: viewer ?? this.viewer,
      amount: amount ?? this.amount,
      watcher: watcher ?? this.watcher,
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
      'publisherUserId': publisherUserId,
      'videoName': videoName,
      'videoPublishedAt': videoPublishedAt,
      'addTime': addTime,
      'videoCommentCount': videoCommentCount,
      'videoDuration': videoDuration,
      'viewDuration': viewDuration,
      'viewer': viewer,
      'amount': amount,
      'watcher': watcher,
      'videoId': videoId,
      'videoViewCount': videoViewCount,
      'videoLikeCount': videoLikeCount,
      'videoThumbnailUrl': videoThumbnailUrl,
      'videoOwnerChannelId': videoOwnerChannelId,
    };
  }

  factory PublishedVideo.fromVideoData(
      {required String docId, required Video video}) {
    DateFormat publishedDateFormat = DateFormat("yyyy-MM-ddThh:mm:ssZ");
    DateTime publishDate =
        publishedDateFormat.parse(video.snippet!.publishedAt.toString());
    var videoDuration = Duration(
        seconds: IsoDuration.parse(video.contentDetails!.duration!.toString())
            .toSeconds()
            .toInt());

    return PublishedVideo(
      docId: docId,
      publisherUserId: userStore.user.uid,
      videoName: video.snippet?.title,
      videoPublishedAt: publishDate,
      addTime: DateTime.now(),
      videoCommentCount: int.tryParse(video.statistics?.commentCount ?? "0"),
      videoDuration: videoDuration.inSeconds,
      viewDuration: publishedVideoStore.duration,
      viewer: publishedVideoStore.viewer,
      amount: publishedVideoStore.totalCreditAmount,
      watcher: [],
      videoId: video.id,
      videoViewCount: int.tryParse(video.statistics?.viewCount ?? "0"),
      videoLikeCount: int.tryParse(video.statistics?.likeCount ?? "0"),
      videoThumbnailUrl: video.snippet!.thumbnails?.medium?.url,
      videoOwnerChannelId: video.snippet?.channelId,
    );
  }

  factory PublishedVideo.fromFirebase(Map<String, dynamic> map) {
    return PublishedVideo(
      docId: map['docId'],
      publisherUserId: map['publisherUserId'],
      videoName: map['videoName'],
      videoPublishedAt: map['videoPublishedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['videoPublishedAt'].seconds)
          : null,
      addTime: map['addTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['addTime'].seconds)
          : null,
      videoCommentCount: map['videoCommentCount']?.toInt(),
      videoDuration: map['videoDuration']?.toInt(),
      viewDuration: map['viewDuration']?.toInt(),
      viewer: map['viewer']?.toInt(),
      amount: map['amount']?.toInt(),
      watcher: map['watcher'] ?? 0,
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
    return 'PublishedVideo(docId: $docId, publisherUserId: $publisherUserId  , videoName: $videoName, videoPublishedAt: $videoPublishedAt, videoPublishedAt: $videoPublishedAt, videoCommentCount: $videoCommentCount, videoDuration: $videoDuration, viewDuration: $viewDuration, viewer: $viewer, amount: $amount, watcher: $watcher  , videoId: $videoId, videoViewCount: $videoViewCount, videoLikeCount: $videoLikeCount, videoThumbnailUrl: $videoThumbnailUrl, videoOwnerChannelId: $videoOwnerChannelId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PublishedVideo &&
        other.docId == docId &&
        other.publisherUserId == publisherUserId &&
        other.videoName == videoName &&
        other.videoPublishedAt == videoPublishedAt &&
        other.addTime == addTime &&
        other.videoCommentCount == videoCommentCount &&
        other.videoDuration == videoDuration &&
        other.viewDuration == viewDuration &&
        other.viewer == viewer &&
        other.amount == amount &&
        other.watcher == watcher &&
        other.videoId == videoId &&
        other.videoViewCount == videoViewCount &&
        other.videoLikeCount == videoLikeCount &&
        other.videoThumbnailUrl == videoThumbnailUrl &&
        other.videoOwnerChannelId == videoOwnerChannelId;
  }

  @override
  int get hashCode {
    return docId.hashCode ^
        publisherUserId.hashCode ^
        videoName.hashCode ^
        videoPublishedAt.hashCode ^
        addTime.hashCode ^
        videoCommentCount.hashCode ^
        videoDuration.hashCode ^
        viewDuration.hashCode ^
        viewer.hashCode ^
        amount.hashCode ^
        watcher.hashCode ^
        videoId.hashCode ^
        videoViewCount.hashCode ^
        videoLikeCount.hashCode ^
        videoThumbnailUrl.hashCode ^
        videoOwnerChannelId.hashCode;
  }
}
