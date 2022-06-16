import 'dart:convert';

import 'package:watch_and_show/models/enums.dart';

class CurrentUser {
  final String? userId;
  final String? name;
  final String? email;
  final double? credits;
  final List<dynamic>? watchVideos;
  final Provider? provider;
  final DateTime? dateOfRegistration;

  CurrentUser({
    required this.userId,
    required this.name,
    required this.email,
    required this.credits,
    required this.watchVideos,
    required this.provider,
    required this.dateOfRegistration,
  });

  factory CurrentUser.fromMap(Map<String, dynamic> map) {
    return CurrentUser(
      userId: map['userId'],
      name: map['name'],
      email: map['email'],
      credits: map['credits'] ?? 0,
      watchVideos: map['watchVideos'] ?? <String>[],
      provider: map['provider'] == "email" ? Provider.email : Provider.google,
      dateOfRegistration: DateTime.fromMillisecondsSinceEpoch(
          map['dateOfRegistration'].seconds * 1000),
    );
  }

  CurrentUser copyWith({
    String? userId,
    String? name,
    String? email,
    List<String>? watchVideos,
    double? credits,
    Provider? provider,
    DateTime? dateOfRegistration,
  }) {
    return CurrentUser(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      watchVideos: watchVideos ?? this.watchVideos,
      email: email ?? this.email,
      credits: credits ?? this.credits,
      provider: provider ?? this.provider,
      dateOfRegistration: dateOfRegistration ?? this.dateOfRegistration,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'name': name,
      'email': email,
      'watchVideos': watchVideos,
      'credits': credits,
      'provider': provider == Provider.email ? "email" : "google",
      'dateOfRegistration': dateOfRegistration,
    };
  }

  String toJson() => json.encode(toMap());

  factory CurrentUser.fromJson(String source) =>
      CurrentUser.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CurrentUser(userId: $userId,name: $name, email: $email, watchVideos: $watchVideos, credits: $credits, provider: $provider, dateOfRegistration: $dateOfRegistration)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CurrentUser &&
        other.userId == userId &&
        other.watchVideos == watchVideos &&
        other.name == name &&
        other.email == email &&
        other.credits == credits &&
        other.provider == provider &&
        other.dateOfRegistration == dateOfRegistration;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        name.hashCode ^
        email.hashCode ^
        credits.hashCode ^
        watchVideos.hashCode ^
        provider.hashCode ^
        dateOfRegistration.hashCode;
  }
}
