import 'package:flutter/material.dart';
import 'package:watch_and_show/core/animated_button.dart';
import 'package:watch_and_show/core/custom_appbar.dart';
import 'package:watch_and_show/global.dart';
import 'package:watch_and_show/models/enums.dart';
import 'package:watch_and_show/services/auth_service.dart';

TextEditingController _emailTextEditingController =
    TextEditingController(text: "email@mail.com");
TextEditingController _passwordTextEditingController =
    TextEditingController(text: "12345678");
TextEditingController _nameTextEditingController = TextEditingController();

class LoginPage extends StatelessWidget {
  final LoginPageType loginPageType;
  const LoginPage({Key? key, required this.loginPageType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(context),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 3),
            child: Column(
              children: [
                const Spacer(flex: 4),
                loginPageType == LoginPageType.create
                    ? formField(
                        textEditingController: _nameTextEditingController,
                        fieldType: _FieldType.name,
                      )
                    : const SizedBox(),
                formField(
                  textEditingController: _emailTextEditingController,
                  fieldType: _FieldType.email,
                ),
                formField(
                  textEditingController: _passwordTextEditingController,
                  fieldType: _FieldType.password,
                ),
                const Spacer(flex: 2),
                button(),
                const Spacer(flex: 3),
              ],
            ),
          ),
        ));
  }

  Padding formField(
      {required TextEditingController textEditingController,
      _FieldType fieldType = _FieldType.email}) {
    final String text = fieldType.name.toUpperCase();
    //  == _FieldType.email ? "E-MAİl" : "PASSWORD";
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: textEditingController,
            decoration: InputDecoration(
              label: Text(text),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
            // onEditingComplete: () {
            //   print("compelete $fieldType");

            // },
            onFieldSubmitted: (s) {
              if (fieldType == _FieldType.password) {
                String email = _emailTextEditingController.text;
                String password = _passwordTextEditingController.text;

                if (loginPageType == LoginPageType.signIn) {
                  signInFirebase(email: email, password: password);
                }
                if (loginPageType == LoginPageType.create) {
                  createAccountFirebase(
                      email: email,
                      password: password,
                      name: _nameTextEditingController.text);
                }
              }
            },
            textInputAction: fieldType == _FieldType.password
                ? TextInputAction.go
                : TextInputAction.next,
          ),
        ],
      ),
    );
  }

  Widget button() {
    final String buttonText =
        loginPageType == LoginPageType.create ? "Create Account" : "Sign In";
    return AnimatedButton(
      text: buttonText,

      onPressed: () {
        String email = _emailTextEditingController.text;
        String password = _passwordTextEditingController.text;

        if (loginPageType == LoginPageType.signIn) {
          signInFirebase(email: email, password: password);
        }
        if (loginPageType == LoginPageType.create) {
          createAccountFirebase(
              email: email,
              password: password,
              name: _nameTextEditingController.text);
        }
        deviceStore.changeLoading(false);
      },
      loading: true,

      // child: Text(buttonText),
    );
  }
}

enum _FieldType {
  email,
  password,
  name,
}
