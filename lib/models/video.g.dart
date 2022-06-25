// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Video _$VideoFromJson(Map<String, dynamic> json) => Video(
      kind: json['kind'] as String?,
      etag: json['etag'] as String?,
      id: json['id'] as String?,
      snippet: json['snippet'] == null
          ? null
          : Snippet.fromJson(json['snippet'] as Map<String, dynamic>),
      contentDetails: json['contentDetails'] == null
          ? null
          : ContentDetails.fromJson(
              json['contentDetails'] as Map<String, dynamic>),
      statistics: json['statistics'] == null
          ? null
          : Statistics.fromJson(json['statistics'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VideoToJson(Video instance) => <String, dynamic>{
      'kind': instance.kind,
      'etag': instance.etag,
      'id': instance.id,
      'snippet': instance.snippet,
      'contentDetails': instance.contentDetails,
      'statistics': instance.statistics,
    };

Snippet _$SnippetFromJson(Map<String, dynamic> json) => Snippet(
      publishedAt: json['publishedAt'] as String?,
      channelId: json['channelId'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      thumbnails: json['thumbnails'] == null
          ? null
          : Thumbnails.fromJson(json['thumbnails'] as Map<String, dynamic>),
      channelTitle: json['channelTitle'] as String?,
      categoryId: json['categoryId'] as String?,
      liveBroadcastContent: json['liveBroadcastContent'] as String?,
      localized: json['localized'] == null
          ? null
          : Localized.fromJson(json['localized'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SnippetToJson(Snippet instance) => <String, dynamic>{
      'publishedAt': instance.publishedAt,
      'channelId': instance.channelId,
      'title': instance.title,
      'description': instance.description,
      'thumbnails': instance.thumbnails,
      'channelTitle': instance.channelTitle,
      'categoryId': instance.categoryId,
      'liveBroadcastContent': instance.liveBroadcastContent,
      'localized': instance.localized,
    };

Localized _$LocalizedFromJson(Map<String, dynamic> json) => Localized(
      title: json['title'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$LocalizedToJson(Localized instance) => <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
    };

ContentDetails _$ContentDetailsFromJson(Map<String, dynamic> json) =>
    ContentDetails(
      duration: json['duration'] as String?,
      dimension: json['dimension'] as String?,
      definition: json['definition'] as String?,
      caption: json['caption'] as String?,
      licensedContent: json['licensedContent'] as bool?,
      contentRating: json['contentRating'] as Map<String, dynamic>?,
      projection: json['projection'] as String?,
    );

Map<String, dynamic> _$ContentDetailsToJson(ContentDetails instance) =>
    <String, dynamic>{
      'duration': instance.duration,
      'dimension': instance.dimension,
      'definition': instance.definition,
      'caption': instance.caption,
      'licensedContent': instance.licensedContent,
      'contentRating': instance.contentRating,
      'projection': instance.projection,
    };

Statistics _$StatisticsFromJson(Map<String, dynamic> json) => Statistics(
      viewCount: json['viewCount'] as String?,
      likeCount: json['likeCount'] as String?,
      favoriteCount: json['favoriteCount'] as String?,
      commentCount: json['commentCount'] as String?,
    );

Map<String, dynamic> _$StatisticsToJson(Statistics instance) =>
    <String, dynamic>{
      'viewCount': instance.viewCount,
      'likeCount': instance.likeCount,
      'favoriteCount': instance.favoriteCount,
      'commentCount': instance.commentCount,
    };

Thumbnails _$ThumbnailsFromJson(Map<String, dynamic> json) => Thumbnails(
      defualt: json['defualt'] == null
          ? null
          : Defualt.fromJson(json['defualt'] as Map<String, dynamic>),
      medium: json['medium'] == null
          ? null
          : Defualt.fromJson(json['medium'] as Map<String, dynamic>),
      high: json['high'] == null
          ? null
          : Defualt.fromJson(json['high'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ThumbnailsToJson(Thumbnails instance) =>
    <String, dynamic>{
      'defualt': instance.defualt,
      'medium': instance.medium,
      'high': instance.high,
    };

Defualt _$DefualtFromJson(Map<String, dynamic> json) => Defualt(
      url: json['url'] as String?,
      width: json['width'] as int?,
      height: json['height'] as int?,
    );

Map<String, dynamic> _$DefualtToJson(Defualt instance) => <String, dynamic>{
      'url': instance.url,
      'width': instance.width,
      'height': instance.height,
    };
