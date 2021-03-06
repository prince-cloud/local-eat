import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_eat/constants.dart';

AppBar homeAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: const Color(0xFFfcc833),
    elevation: 0,
    leading: IconButton(
      icon: const Icon(Icons.menu),
      onPressed: () {},
      color: primaryColor,
    ),
    title: RichText(
      text: const TextSpan(
        /* style: Theme.of(context)
            .textTheme
            .title
            .copyWith(fontWeight: FontWeight.bold), */
        children: [
          TextSpan(
            text: "Local",
            style: TextStyle(
              color: blackColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          TextSpan(
            text: " Eat",
            style: TextStyle(
              color: whiteColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    ),
    /* actions: <Widget>[
      IconButton(
        icon: SvgPicture.asset("assets/icons/notification.svg"),
        onPressed: () {},
      ),
    ], */
  );
}
