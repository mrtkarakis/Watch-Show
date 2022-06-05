import 'package:watch_and_show/extensions/string.dart';

extension DurationExtension on Duration {
  String toText() {
    if (inHours != 0) {
      return "${(inHours % 60).toString().withZero()}:${(inMinutes % 60).toString().withZero()}:${(inSeconds % 60).toString().withZero()}";
    }
    return "${(inMinutes % 60).toString().withZero()}:${(inSeconds % 60).toString().withZero()}";
  }
}
