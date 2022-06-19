import 'package:flutter/material.dart';
import 'package:watch_and_show/core/animated_button.dart';
import 'package:watch_and_show/core/custom_appbar.dart';
import 'package:watch_and_show/global.dart';
import 'package:watch_and_show/models/enums.dart';
import 'package:watch_and_show/pages/loginPage/login_view.dart';

class LoginRegisterPage extends StatelessWidget {
  const LoginRegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    deviceStore.setDeviceSize(context);

    Widget loginOrSignInButton({required LoginPageType loginPageType}) {
      final String text =
          loginPageType == LoginPageType.create ? "Create Account" : "Sign In";
      return AnimatedButton(
        text: text,
        loading: false,
        waitAnimation: true,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => LoginPage(
                    loginPageType: loginPageType,
                  )),
        ),
      );
    }

    return Scaffold(
      appBar: customAppBar(context, leadingButton: false),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 5),
        child: Column(
          children: [
            const Spacer(flex: 2),
            imageBox(),
            const Spacer(flex: 2),
            loginOrSignInButton(loginPageType: LoginPageType.create),
            const Spacer(),
            loginOrSignInButton(loginPageType: LoginPageType.signIn),
            const Spacer(flex: 2),
          ],
        ),
      )),
    );
  }

  ElevatedButton loginWithGoogle() {
    return ElevatedButton(
      onPressed: () {},
      child: const Text(
        "Google",
        style: TextStyle(color: Colors.black),
      ),
      style: ElevatedButton.styleFrom(
          minimumSize: Size(deviceStore.width / 1.3, 55),
          primary: Colors.white),
    );
  }

  Widget imageBox() {
    return Center(
      child: Container(
        height: deviceStore.width / 1.3,
        width: deviceStore.width / 1.3,
        color: Colors.red,
        child: const Center(child: Text("IMAGE")),
      ),
    );
  }
}
