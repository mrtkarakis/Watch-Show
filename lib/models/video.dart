import 'package:json_annotation/json_annotation.dart';

part 'video.g.dart';

@JsonSerializable()
class Video {
  String? kind;
  String? etag;
  String? id;
  Snippet? snippet;
  ContentDetails? contentDetails;
  Statistics? statistics;

  Video(
      {this.kind,
      this.etag,
      this.id,
      this.snippet,
      this.contentDetails,
      this.statistics});

  factory Video.fromJson(Map<String, dynamic> json) => _$VideoFromJson(json);

  Map<String, dynamic> toJson() => _$VideoToJson(this);
}

@JsonSerializable()
class Snippet {
  String? publishedAt;
  String? channelId;
  String? title;
  String? description;
  Thumbnails? thumbnails;
  String? channelTitle;
  String? categoryId;
  String? liveBroadcastContent;
  Localized? localized;

  Snippet(
      {this.publishedAt,
      this.channelId,
      this.title,
      this.description,
      this.thumbnails,
      this.channelTitle,
      this.categoryId,
      this.liveBroadcastContent,
      this.localized});

  factory Snippet.fromJson(Map<String, dynamic> json) =>
      _$SnippetFromJson(json);

  Map<String, dynamic> toJson() => _$SnippetToJson(this);
}

@JsonSerializable()
class Localized {
  String? title;
  String? description;

  Localized({this.title, this.description});

  factory Localized.fromJson(Map<String, dynamic> json) =>
      _$LocalizedFromJson(json);

  Map<String, dynamic> toJson() => _$LocalizedToJson(this);
}

@JsonSerializable()
class ContentDetails {
  String? duration;
  String? dimension;
  String? definition;
  String? caption;
  bool? licensedContent;
  Map? contentRating;
  String? projection;

  ContentDetails(
      {this.duration,
      this.dimension,
      this.definition,
      this.caption,
      this.licensedContent,
      this.contentRating,
      this.projection});

  factory ContentDetails.fromJson(Map<String, dynamic> json) =>
      _$ContentDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$ContentDetailsToJson(this);
}

@JsonSerializable()
class Statistics {
  String? viewCount;
  String? likeCount;
  String? favoriteCount;
  String? commentCount;

  Statistics(
      {this.viewCount, this.likeCount, this.favoriteCount, this.commentCount});

  factory Statistics.fromJson(Map<String, dynamic> json) =>
      _$StatisticsFromJson(json);

  Map<String, dynamic> toJson() => _$StatisticsToJson(this);
}

@JsonSerializable()
class Thumbnails {
  Defualt? defualt;
  Defualt? medium;
  Defualt? high;

  Thumbnails({this.defualt, this.medium, this.high});

  factory Thumbnails.fromJson(Map<String, dynamic> json) =>
      _$ThumbnailsFromJson(json);

  Map<String, dynamic> toJson() => _$ThumbnailsToJson(this);
}

@JsonSerializable()
class Defualt {
  String? url;
  int? width;
  int? height;

  Defualt({this.url, this.width, this.height});

  factory Defualt.fromJson(Map<String, dynamic> json) =>
      _$DefualtFromJson(json);

  Map<String, dynamic> toJson() => _$DefualtToJson(this);
}
