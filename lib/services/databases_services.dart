import 'package:cloud_firestore/cloud_firestore.dart';

class DatabasesServices {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  final CollectionReference<Map<String, dynamic>> usersDb =
      db.collection("users");
  final CollectionReference<Map<String, dynamic>> channelsDb =
      db.collection("channels");
  final CollectionReference<Map<String, dynamic>> videosDb =
      db.collection("videos");
  final CollectionReference<Map<String, dynamic>> publishedVideoDb =
      db.collection("publishedVideo");
}
