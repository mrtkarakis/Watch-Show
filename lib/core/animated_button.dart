// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:watch_and_show/global.dart';
import 'package:watch_and_show/styles/app_theme.dart';

// ignore: must_be_immutable
class AnimatedButton extends StatefulWidget {
  final String text;
  Color? textColor;
  final Color bgColor;
  final LinearGradient? linearGradient;
  final Alignment textAlignment;
  final int milliseconds;
  final double height;
  double? width;
  final bool shadow;
  late bool? active;
  final bool waitAnimation;
  final Offset shadowOffset;
  final Color shadowColor;
  final double shadowRadius;
  Function? onPressed;
  final bool loading;

  AnimatedButton({
    Key? key,
    required this.text,
    this.active,
    this.textColor,
    this.bgColor = Colors.white,
    this.linearGradient,
    this.textAlignment = const Alignment(0, 0.2),
    this.milliseconds = 500,
    this.height = 55,
    this.width,
    this.shadow = true,
    this.waitAnimation = false,
    this.shadowOffset = const Offset(-2, 7),
    this.shadowColor = Colors.grey,
    this.shadowRadius = 12,
    this.onPressed,
    this.loading = true,
  }) : super(key: key);

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> {
  @override
  void initState() {
    super.initState();
  }

  bool animated = false;
  bool isTimer = false;
  Timer? timer;

  GlobalKey<State<StatefulWidget>> buttonKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    widget.active = widget.active ?? widget.onPressed != null;
    widget.textColor =
        widget.textColor ?? AppTheme().theme().colorScheme.primary;

    return SizedBox(
      width: widget.width,
      child: Stack(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: widget.milliseconds),
            onEnd: () {
              timer = Timer(
                  Duration(milliseconds: (widget.milliseconds * 1.5).toInt()),
                  () {
                // if (widget.loading && deviceStore.loading) {
                //   timer =
                //       Timer.periodic(const Duration(milliseconds: 500), (timer) {
                //     setState(() => animated = false);
                //     isTimer = false;
                //   });
                // } else if (!widget.loading) {
                Future.microtask(() => setState(() => animated = false));
                isTimer = false;
                // }
              });
            },
            height: widget.height,
            width: animated ? widget.width : widget.height,
            decoration: BoxDecoration(
                boxShadow: widget.shadow
                    ? [
                        BoxShadow(
                            offset: widget.shadowOffset,
                            blurRadius: widget.shadowRadius,
                            color: widget.shadowColor,
                            spreadRadius: -1)
                      ]
                    : null,
                color: widget.bgColor,
                borderRadius: BorderRadius.circular(widget.height / 2),
                gradient: widget.linearGradient),
          ),
          ElevatedButton(
            key: buttonKey,
            onPressed: (widget.loading && deviceStore.loading) ||
                    !(widget.active ?? false)
                ? () {}
                : () {
                    final keyContext = buttonKey.currentContext;
                    // widget is visible
                    final box = keyContext!.findRenderObject() as RenderBox;
                    print(box.size.width);
                    widget.width = box.size.width;

                    // if (widget.loading) {
                    //   deviceStore.changeLoading(true);
                    // }
                    if (!isTimer) {
                      isTimer = true;
                      timer?.cancel();
                    }
                    setState(() {
                      animated = true;
                    });

                    if (widget.onPressed != null) {
                      if (widget.waitAnimation) {
                        Future.delayed(
                            Duration(milliseconds: widget.milliseconds + 250),
                            () {
                          print("onPressed");
                          widget.onPressed!();
                        });
                      } else {
                        print("onPressed");
                        widget.onPressed!();
                      }
                    }
                  },
            child: Observer(
              builder: (_) {
                bool loading = widget.loading && deviceStore.loading;
                print("loading  $loading");
                return loading
                    ? const Center(child: CircularProgressIndicator())
                    : Text(
                        widget.text,
                        style: TextStyle(
                            color: widget.textColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      );
              },
            ),
            style: ElevatedButton.styleFrom(
              alignment: widget.textAlignment,
              elevation: 0,
              splashFactory: NoSplash.splashFactory,
              primary: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: const StadiumBorder(),
              minimumSize: Size(widget.width ?? 130, widget.height),
            ),
          ),
        ],
      ),
    );
  }
}
