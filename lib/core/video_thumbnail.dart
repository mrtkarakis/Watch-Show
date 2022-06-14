import 'package:flutter/material.dart';

class VideoThumbnail extends StatelessWidget {
  const VideoThumbnail({
    Key? key,
    required this.src,
    this.width = 150,
  }) : super(key: key);
  final String? src;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Image(
      key: Key(src ?? DateTime.now().toString()),
      width: width,
      image: NetworkImage(src ?? ""),
    );
  }
}
