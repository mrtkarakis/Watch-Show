import 'package:flutter/material.dart';

AppBar customAppBar(BuildContext context, {bool leadingButton = true}) {
  return AppBar(
    leading: leadingButton
        ? IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () => Navigator.pop(context),
          )
        : null,
    title: const Text("Title"),
    automaticallyImplyLeading: false,
    centerTitle: true,
    elevation: 0,
  );
}
