import 'package:flutter/material.dart';
import 'package:watch_and_show/global.dart';

class SetWatchVideoViewer extends StatefulWidget {
  const SetWatchVideoViewer({Key? key}) : super(key: key);

  @override
  State<SetWatchVideoViewer> createState() => _SetWatchVideoViewerState();
}

class _SetWatchVideoViewerState extends State<SetWatchVideoViewer> {
  // int viewer = 500;
  int range = 25;
  static const String text = "Watch Viewer";
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Column(
        children: [
          const Text(
            text,
            style: TextStyle(fontSize: 15),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: .8),
                borderRadius: BorderRadius.circular(6)),
            child: Text(
              "${publishedVideoStore.viewer}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                button(setType: _SetType.decrease),
                const SizedBox(width: 22),
                button(setType: _SetType.increas),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget button({required _SetType setType}) {
    const double iconSize = 50;
    bool increase = setType.data["increase"];
    bool active = increase
        ? (publishedVideoStore.viewer + range) <= 1000
        : (publishedVideoStore.viewer - range) >= 250;

    return OutlinedButton(
      onPressed: active
          ? () {
              setState(() {
                if (increase) {
                  publishedVideoStore.viewer =
                      publishedVideoStore.viewer + range;
                } else {
                  publishedVideoStore.viewer =
                      publishedVideoStore.viewer - range;
                }
                developerLog("${publishedVideoStore..viewer}",
                    name: "duration");
              });
            }
          : null,
      style: OutlinedButton.styleFrom(
        shape: const CircleBorder(),
        minimumSize: const Size(iconSize, iconSize),
        primary: Colors.white,
        side: BorderSide(
            color: active
                ? increase
                    ? Colors.green.shade300
                    : Colors.red.shade300
                : Colors.grey),
        onSurface: Colors.grey,
      ),
      child: Icon(
        setType.data["icon"],
      ),
    );
  }
}

enum _SetType {
  increas({"icon": Icons.add, "increase": true}),
  decrease({"icon": Icons.remove, "increase": false});

  final Map<String, dynamic> data;
  const _SetType(this.data);
}
