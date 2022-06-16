library store.store;

import 'dart:async';
import 'dart:developer' as developer;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:watch_and_show/services/databases_services.dart';
import 'package:watch_and_show/store/channelStore/channel_store.dart';
import 'package:watch_and_show/store/deviceStore/device_store.dart';
import 'package:watch_and_show/store/publishedVideoStore/published_video_store.dart';
import 'package:watch_and_show/store/userStore/user_store.dart';
import 'package:watch_and_show/store/videosStore/videos_store.dart';

UserStore userStore = UserStore();
DeviceStore deviceStore = DeviceStore();
ChannelStore channelStore = ChannelStore();
PublishedVideoStore publishedVideoStore = PublishedVideoStore();
VideosStore videosStore = VideosStore();

FirebaseAuth auth = FirebaseAuth.instance;

//database
DatabasesServices dbServices = DatabasesServices();

//log
void developerLog(
  String? message, {
  final String name = "developerLog",
  final Object? error,
  final int level = 0,
  final int? sequenceNumber,
  final StackTrace? stackTrace,
  DateTime? time,
  final Zone? zone,
}) {
  message = message ?? "";
  time = time ?? DateTime.now();
  developer.log("-time : $time-  $message",
      name: name,
      error: error,
      level: level,
      sequenceNumber: sequenceNumber,
      stackTrace: stackTrace,
      time: time,
      zone: zone);
}
