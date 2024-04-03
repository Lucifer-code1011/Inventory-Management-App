import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:learn_flutter/constants/constants.dart';
import 'package:dotted_border/dotted_border.dart';

class Import extends StatelessWidget {
  final void Function()? onTap;
  final File? selectedImage;

  const Import({
    Key? key,
    required this.onTap,
    required this.selectedImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: DottedBorder(
        dashPattern: [6, 3], // Adjust the dash pattern as needed
        color: const Color.fromARGB(255, 200, 199, 199),
        strokeWidth: 2,
        borderType: BorderType.RRect, // You can use other BorderTypes as well
        radius: const Radius.circular(20),
        child: Container(
          width: 360,
          height: 240,
          padding: const EdgeInsets.only(
            top: 5,
            left: 5,
            right: 5,
            bottom: 5,
          ),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: whitesomke,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color.fromARGB(177, 223, 222, 222)),
          ),
          child: selectedImage != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    selectedImage!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      IconlyLight.upload,
                      color: grey,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Drag & Drop or ',
                          style: GoogleFonts.poppins(
                            color: grey,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                        Text(
                          'Choose file',
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF136AF3),
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                        Text(
                          ' to upload',
                          style: GoogleFonts.poppins(
                            color: grey,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
