import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/constants.dart';
import '../controller/validators.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final IconData icon;
  final bool isObscure;
  final TextInputType type;
  const MyTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.icon,
      required this.isObscure,
      required this.type,
      required this.labelText});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 0.0),
          child: Text(
            labelText,
            style: GoogleFonts.poppins(
                color: black, fontSize: 12, fontWeight: FontWeight.normal),
          ),
        ),
        TextFormField(
            controller: controller,
            obscureText: isObscure,
            keyboardType: type,
            decoration: InputDecoration(
                fillColor: whitesomke,
                filled: true,
                prefixIconColor: lightGrey,
                prefixIcon: Icon(
                  icon,
                  size: 20,
                  color: Colors.black,
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        color: Color.fromARGB(177, 223, 222, 222))),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none),
                contentPadding: const EdgeInsets.fromLTRB(15, 30, 15, 2),
                hintMaxLines: 1,
                hintText: hintText),
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: black,
              fontWeight: FontWeight.w400,
            ),
            validator: (value) =>
                Validator.validateEmail(email: value.toString())),
      ],
    );
  }
}
