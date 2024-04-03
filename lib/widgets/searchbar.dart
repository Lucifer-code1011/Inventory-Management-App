import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:learn_flutter/constants/constants.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SizedBox(
        height: 45,
        child: TextFormField(
          textAlignVertical: TextAlignVertical.center,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            alignLabelWithHint: true,
            fillColor: Color.fromARGB(255, 120, 185, 120),
            filled: false,
            prefixIconColor: black,
            prefixIcon: const Icon(
              IconlyLight.search,
              size: 18,
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide.none),
            contentPadding:
                const EdgeInsets.fromLTRB(padding * 3, 0, padding, 0),
            hintText: 'Search',
            hintStyle:
                TextStyle(fontFamily: 'Gilmer', fontSize: 15, color: grey),
          ),
          style: TextStyle(
            fontFamily: 'Gilmer',
            fontSize: 15,
            color: black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
