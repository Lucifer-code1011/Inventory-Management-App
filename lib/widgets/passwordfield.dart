import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import '../constants/constants.dart';
import '../controller/validators.dart';

class MyPasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final bool isObscure;
  const MyPasswordField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.icon,
      required this.isObscure});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        obscureText: isObscure,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            fillColor: whitesomke,
            filled: true,
            prefixIconColor: lightGrey,
            prefixIcon: Icon(
              icon,
              size: 20,
            ),
            suffixIconColor: lightGrey,
            suffixIcon: const Icon(
              FluentIcons.eye_off_16_regular,
              size: 20,
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none),
            contentPadding: const EdgeInsets.fromLTRB(15, 30, 15, 2),
            hintMaxLines: 1,
            hintText: hintText),
        style: TextStyle(
          fontFamily: 'Gilmer',
          fontSize: 14,
          color: black,
          fontWeight: FontWeight.w400,
        ),
        validator: (value) => Validator.validateEmail(email: value.toString()));
  }
}
