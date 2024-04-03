import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyCard extends StatelessWidget {
  final String name;
  final String price;
  final String desc;
  final String image;
  final String count;
  final Function()? onTap;
  const MyCard(
      {super.key,
      required this.name,
      required this.price,
      required this.desc,
      required this.image,
      required this.count,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 360,
            height: 140,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(color: Colors.white),
            child: Stack(
              children: [
                Positioned(
                  left: 3,
                  top: 0,
                  child: Container(
                    width: 347,
                    height: 123,
                    decoration: ShapeDecoration(
                      color: const Color.fromARGB(108, 232, 238, 240),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            width: 1,
                            color: Color.fromARGB(255, 219, 236, 236)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 21,
                  top: 11,
                  child: SizedBox(
                    width: 104,
                    height: 26,
                    child: Text(
                      name,
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 143,
                  top: 83,
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 163, 147, 219),
                        borderRadius: BorderRadius.circular(5)),
                    width: 60,
                    height: 25,
                    child: Center(
                      child: Text(
                        'Rs $price',
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 21,
                  top: 40,
                  child: SizedBox(
                    width: 195,
                    height: 36,
                    child: Text(
                      desc,
                      style: GoogleFonts.poppins(
                        color: const Color.fromARGB(255, 115, 115, 115),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 238,
                  top: 10,
                  child: Image.network(image,
                      height: 100, width: 100, fit: BoxFit.contain),
                ),
                Positioned(
                  left: 21,
                  top: 85,
                  child: SizedBox(
                    width: 120,
                    height: 26,
                    child: Text(
                      'No of products :',
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 335,
                  top: 0,
                  child: SizedBox(
                    width: 25,
                    height: 25,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                        height: 25,
                        width: 25,
                        decoration: const BoxDecoration(
                          color: Colors.black,
                        ),
                        child: Center(
                          child: Text(
                            count.toString(),
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
