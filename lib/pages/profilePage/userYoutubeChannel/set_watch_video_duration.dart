import 'package:flutter/material.dart';
import 'package:watch_and_show/global.dart';

class SetWatchVideoDuration extends StatefulWidget {
  const SetWatchVideoDuration({
    Key? key,
    required this.videoDurationSecond,
  }) : super(key: key);
  final int videoDurationSecond;

  @override
  State<SetWatchVideoDuration> createState() => _SetWatchVideoDurationState();
}

class _SetWatchVideoDurationState extends State<SetWatchVideoDuration> {
  // int duration = 90;
  int range = 15;
  static const String text = "Watch Duration";
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
              "${publishedVideoStore.duration}",
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
        ? (widget.videoDurationSecond > (publishedVideoStore.duration + range))
        : (publishedVideoStore.duration - range) >= 30;

    return OutlinedButton(
      onPressed: active
          ? () {
              setState(() {
                if (increase) {
                  publishedVideoStore.duration =
                      publishedVideoStore.duration + range;
                } else {
                  publishedVideoStore.duration =
                      publishedVideoStore.duration - range;
                }
                developerLog("${publishedVideoStore.duration}",
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
