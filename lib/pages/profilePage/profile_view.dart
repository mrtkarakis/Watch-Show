import 'package:flutter/material.dart';
import 'package:watch_and_show/global.dart';
import 'package:watch_and_show/pages/loginPage/login_register_page.dart';
import 'package:watch_and_show/pages/profilePage/userYoutubeChannel/addVideoPage/add_Video_view.dart';
import 'package:watch_and_show/pages/profilePage/userYoutubeChannel/user_youtube_channel_view.dart';
import 'package:watch_and_show/styles/app_theme.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 22.0),
                child: Text(
                  "Profile",
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              const _UserInfoContainer(userInfoType: _UserInfoType.name),
              const _UserInfoContainer(userInfoType: _UserInfoType.email),
              const _UserInfoContainer(userInfoType: _UserInfoType.credits),
              settingButton(
                buttonName: "Youtube Channel",
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => channelStore.channel != null
                        ? const UserYouTubeChannelPage()
                        : AddVideoPage(),
                  ),
                ),
              ),
              settingButton(buttonName: "Settings", onPressed: () {}),
              const Spacer(),
              TextButton(
                  onPressed: () async {
                    deviceStore.changeLoading(true);
                    await auth.signOut();
                    channelStore.channel = null;
                    userStore.userData = null;

                    deviceStore.changeLoading(false);
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const LoginRegisterPage()),
                        (route) => false);
                  },
                  child: const Text("Log Out")),
              const SizedBox(height: 35),
            ],
          ),
        ),
      ),
    ));
  }

  Widget settingButton({
    required String buttonName,
    Function()? onPressed,
  }) {
    return TextButton(
      onPressed: onPressed ?? () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 6),
        child: Row(
          children: [
            Text(buttonName),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios_rounded)
          ],
        ),
      ),
    );
  }
}

String _returnHeader(_UserInfoType userInfoType) {
  switch (userInfoType) {
    case _UserInfoType.name:
      return "Name";

    case _UserInfoType.email:
      return "E-Mail";

    case _UserInfoType.credits:
      return "Credits";

    default:
      return "Header";
  }
}

enum _UserInfoType {
  name,
  email,
  credits,
}

class _UserInfo {
  final String? header;
  final String? data;

  _UserInfo({
    this.header,
    this.data,
  });

  factory _UserInfo.fromData({
    required Map<String, dynamic> map,
    required String headerKey,
    required String dataKey,
  }) {
    return _UserInfo(
      header: headerKey,
      data: "${map[dataKey]}",
    );
  }
}

class _UserInfoContainer extends StatefulWidget {
  final _UserInfoType userInfoType;

  const _UserInfoContainer({
    Key? key,
    required this.userInfoType,
  }) : super(key: key);

  @override
  State<_UserInfoContainer> createState() => __UserInfoContainerState();
}

class __UserInfoContainerState extends State<_UserInfoContainer> {
  double buttonWidth = deviceStore.width / 2.5;
  double buttonHeight = 45;

  @override
  Widget build(BuildContext context) {
    String header = _returnHeader(widget.userInfoType);

    _UserInfo _userInfo = _UserInfo.fromData(
      map: userStore.userData!.toMap(),
      headerKey: header,
      dataKey: widget.userInfoType.name,
    );

    return _userInfo.data == "null"
        ? const SizedBox()
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${_userInfo.header}",
                    style: AppTheme().textTheme.headline2,
                  ),
                  const SizedBox(height: 5),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        buttonWidth = buttonWidth == deviceStore.width
                            ? deviceStore.width / 2.5
                            : deviceStore.width;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 555),
                      height: buttonHeight,
                      width: buttonWidth,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white10),
                      child: Text(
                        "${_userInfo.data}",
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    style: TextButton.styleFrom(
                        splashFactory: NoSplash.splashFactory),
                  )
                ],
              ),
            ),
          );
  }
}
