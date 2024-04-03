import 'package:fluentui_system_icons/fluentui_system_icons.dart';

import '../constants/constants.dart';
import 'package:flutter/material.dart';

class MyProfileButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function()? onTap;
  final Color color;
  final Color backgroundcolor;
  final Color textcolor;

  const MyProfileButton(
      {super.key,
      required this.text,
      required this.onTap,
      required this.icon,
      required this.color,
      required this.textcolor,
      required this.backgroundcolor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      width: 350,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: backgroundcolor,
            foregroundColor: black,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  size: 22,
                  color: color,
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  text,
                  style: TextStyle(
                    fontFamily: 'Gilmer',
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: textcolor,
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 100,
            ),
            const Icon(
              FluentIcons.chevron_right_16_regular,
              size: 20,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
