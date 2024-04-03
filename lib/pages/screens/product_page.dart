import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_flutter/constants/constants.dart';

class ProductDetail extends StatelessWidget {
  final String productName;
  final String productPrice;
  final String productDescription;
  final String productImage;

  const ProductDetail({
    super.key,
    required this.productName,
    required this.productPrice,
    required this.productDescription,
    required this.productImage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Details',
          style: TextStyle(
              fontFamily: 'Gilmer',
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: black),
        ),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            FluentIcons.arrow_left_16_regular,
            color: black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image.network(
                productImage,
                height: 260,
                width: 260,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20.0),
            const SizedBox(height: 40.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  productName,
                  style: GoogleFonts.poppins(
                      fontSize: 28.0,
                      fontWeight: FontWeight.w500,
                      color: black),
                ),
                Text(
                  'Rs $productPrice',
                  style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.green),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                starRating(),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  '(1k reviews)',
                  style: GoogleFonts.poppins(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                      color: lightGrey),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed nec consectetur libero. Fusce non ex eget ex tristique efficitur. Curabitur ac justo mauris. Ut vulputate pellentesque ante, vel posuere lorem vestibulum sed. Suspendisse at mollis turpis, eu cursus massa. Sed facilisis nulla id nunc volutpat, euismod rutrum risus tristique. vel posuere lorem vestibulum sed. Suspendisse at mollis turpis, eu cursus massa. Sed facilisis nulla id nunc volutpat, euismod rutrum risus tristique. ',
              style: GoogleFonts.poppins(
                  fontSize: 14.0,
                  fontWeight: FontWeight.normal,
                  color: lightGrey),
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              maxLines: 8,
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                calorieWt(),
                const SizedBox(
                  width: 20,
                ),
                foodTime(),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total : Rs $productPrice',
                  style: GoogleFonts.poppins(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                      color: black),
                ),
                const SizedBox(
                  width: 20,
                ),
                addButton(() {}),
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget starRating() {
  return Container(
    height: 30,
    width: 70,
    padding: const EdgeInsets.all(0),
    decoration: BoxDecoration(
        color: const Color(0xff1e1e1e),
        borderRadius: BorderRadius.circular(25)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 0.0),
          child: Icon(
            FluentIcons.star_16_regular,
            color: white,
            size: 15,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 0.0, right: 10.0),
          child: Text(
            '4.9',
            style: GoogleFonts.poppins(
                fontSize: 14, fontWeight: FontWeight.w500, color: white),
          ),
        ),
      ],
    ),
  );
}

Widget foodTime() {
  return Text.rich(
    TextSpan(
      style: TextStyle(
          fontFamily: 'Gilmer',
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: lightGrey),
      children: [
        WidgetSpan(
          child: Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: Icon(
              FluentIcons.clock_16_regular,
              color: orange1,
              size: 20,
            ),
          ),
        ),
        const TextSpan(
          text: '25min',
        )
      ],
    ),
  );
}

Widget calorieWt() {
  return Text.rich(
    TextSpan(
      style: GoogleFonts.poppins(
          fontSize: 14, fontWeight: FontWeight.w500, color: lightGrey),
      children: [
        WidgetSpan(
          child: Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: Icon(
              FluentIcons.lock_closed_16_regular,
              color: orange1,
              size: 20,
            ),
          ),
        ),
        const TextSpan(
          text: '128.6 kkal',
        )
      ],
    ),
  );
}

Widget addButton(onTap) {
  return SizedBox(
    height: 50,
    width: 200,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff1e1e1e),
          foregroundColor: white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
      onPressed: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Add to cart',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ), // <-- Text
        ],
      ),
    ),
  );
}
