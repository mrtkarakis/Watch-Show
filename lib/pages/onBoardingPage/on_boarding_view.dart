import 'package:flutter/material.dart';
import 'package:watch_and_show/core/animated_button.dart';
import 'package:watch_and_show/global.dart';
import 'package:watch_and_show/pages/loginPage/login_register_page.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    deviceStore.setDeviceSize(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.amber,
              // gradient: LinearGradient(
              //   begin: Alignment.topCenter,
              //   end: Alignment.bottomCenter,
              //   colors: [Colors.red, Colors.green],
              // ),
            ),
          ),
          const Align(
            alignment: Alignment(0, -0.9),
            child: FlutterLogo(),
          ),
          PageView.builder(
              onPageChanged: (page) =>
                  Future.microtask(() => setState(() => pageIndex = page)),
              itemCount: 3,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    // onBoardingBackgroundImage(context, index),
                    Align(
                      alignment: const Alignment(-0.4, 0.45),
                      child: onBoardingMessage(index),
                    ),
                  ],
                );
              }),
          Align(
              alignment: const Alignment(0, 0.63),
              child: onBoardingPageCounter(pageIndex)),
          Align(
              alignment: const Alignment(0, 0.92),
              child: AnimatedButton(
                text: "Next",
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const LoginRegisterPage()),
                      ((route) => false));
                },
                loading: false,
                waitAnimation: true,
              )),
        ],
      ),
    );
  }

  Align onBoardingBackgroundImage(BuildContext context, int index) => Align(
      alignment: const Alignment(0, -0.24),
      child: Container(
        height: deviceStore.height / 2.5,
        width: deviceStore.width / 1.7,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Image.asset("assets/images/onboarding_$index.png"),
      ));

  Widget onBoardingSkipButton(
    BuildContext context,
  ) =>
      TextButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const LoginRegisterPage()));
          },
          child: Text("skip"));

  Widget onBoardingStartButton(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 98.0),
        child: ElevatedButton(
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const LoginRegisterPage())),
            child: Text("start_explore")),
      );

  Widget onBoardingMessage(int index) {
    // String title = "onboarding.title$index", text = "onboarding.text$index";
    String
        // title = "LOREM IPSUM",
        text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit.";

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
              flex: 14,
              child: Text(
                text,
              ))
        ],
      ),
    );
  }

  Widget onBoardingPageCounter(int pageIndex) {
    Widget circulars(int index) {
      bool isPage = index == pageIndex;
      return AnimatedContainer(
        duration: const Duration(milliseconds: 222),
        height: 8,
        width: isPage ? 25 : 8,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            color: isPage ? Colors.blueAccent : const Color(0XFFDBDBDB)),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        circulars(0),
        const SizedBox(width: 3),
        circulars(1),
        const SizedBox(width: 3),
        circulars(2)
      ],
    );
  }
}
