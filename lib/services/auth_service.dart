import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:watch_and_show/global.dart';
import 'package:watch_and_show/models/enums.dart';
import 'package:watch_and_show/models/user.dart';
import 'package:watch_and_show/pages/bottomNavigationBar/bottom_navigation_bar.dart';
import 'package:watch_and_show/services/global_services.dart';

Future<void> signInFirebase(
    {required String email, required String password}) async {
  developerLog("email $email , password $password", name: "signInFirebase");

  await FirebaseAuth.instance
      .signInWithEmailAndPassword(
    email: email,
    password: password,
  )
      .then((value) async {
    CurrentUser? currentUser;
    User user = value.user!;
    await dbServices.usersDb.doc(user.uid).get().then(
      (data) {
        Map<String, dynamic>? userData = (data.data());
        print(userData);
        currentUser = CurrentUser.fromMap(userData as Map<String, dynamic>);
        print(currentUser);
        userStore.userData = currentUser;

        _navigationHomePage(NavigationService.navigatorKey.currentContext!);
      },
    );
    developerLog(currentUser.toString(), name: "signInFirebase");
  }).catchError((onError) {
    developerLog("$onError", name: "signInFirebase");
  });
}

Future<void> createAccountFirebase(
    {required String email,
    required String password,
    required String name}) async {
  developerLog("email $email , password $password",
      name: "createAccountFirebase");

  await FirebaseAuth.instance
      .createUserWithEmailAndPassword(
    email: email,
    password: password,
  )
      .then((value) async {
    User user = value.user!;
    CurrentUser currentUser = CurrentUser(
      name: name,
      userId: user.uid,
      email: user.email,
      credits: null,
      provider: Provider.email,
      dateOfRegistration: DateTime.now(),
    );
    userStore.userData = currentUser;
    await dbServices.usersDb
        .doc(currentUser.userId)
        .set(currentUser.toMap())
        .then((value) => _navigationHomePage(
            NavigationService.navigatorKey.currentContext!));
  }).catchError((onError) {
    developerLog("$onError", name: "createAccountFirebase");
  });
}

void _navigationHomePage(BuildContext context) => Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const BottomBarNavigation()),
    );
