import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watch_and_show/global.dart';
import 'package:watch_and_show/models/user.dart';
import 'package:watch_and_show/pages/bottomNavigationBar/bottom_navigation_bar.dart';
import 'package:watch_and_show/pages/loginPage/login_register_page.dart';
import 'package:watch_and_show/pages/loginPage/login_view.dart';

import 'pages/onBoardingPage/on_boarding_view.dart';
import 'services/global_services.dart';
import 'services/youtube_services.dart';
import 'styles/app_theme.dart';

Widget _initialRoute = const OnBoardingPage();
int? _initScreen;
SharedPreferences? sharedPreferences;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  _initScreen = sharedPreferences!.getInt("initScreen");
  await _authState().then(
    (value) {
      runApp(const MyApp());
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  final String title = "Watch & Show";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MaterialApp(
        navigatorKey: NavigationService.navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: AppTheme().theme(),
        home: _initialRoute,
      ),
    );
  }
}

Future<void> _authState() async {
  if (_initScreen == 0 || _initScreen == null) {
    _initialRoute = const OnBoardingPage();
    await sharedPreferences!.setInt("initScreen", 1);
  } else if (auth.currentUser != null) {
    userStore.setUser(auth.currentUser!);

    await dbServices.usersDb
        .where("userId", isEqualTo: userStore.user.uid)
        .limit(1)
        .get()
        .then((where) async {
      if (where.size == 0) {
        _initialRoute = const LoginRegisterPage();
      } else {
        Map<String, dynamic> data = where.docs.first.data();
        userStore.userData = CurrentUser.fromMap(data);
        YoutubeService.instance.initChannel();

        // userStore.userData.addEntries(map.entries);

        _initialRoute = const BottomBarNavigation();
      }
    });
  } else {
    _initialRoute = const LoginRegisterPage();
  }
}
