import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:learn_flutter/bottom.dart';
import 'package:learn_flutter/constants/constants.dart';
import 'package:learn_flutter/widgets/appbar.dart';
import 'package:learn_flutter/widgets/card.dart';
import 'package:learn_flutter/widgets/chart.dart';
import 'package:learn_flutter/widgets/dashboard.dart';
import 'package:learn_flutter/widgets/textfield.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MyAppBar(),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
              child: MyTextField(
                controller: searchController,
                hintText: 'Search Products... ',
                icon: IconlyLight.search,
                isObscure: false,
                type: TextInputType.text,
                labelText: '',
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Options(
                  text: 'Total',
                  color: const Color.fromARGB(188, 124, 77, 255),
                ),
                Options(
                  text: 'Incoming',
                  color: const Color.fromARGB(176, 255, 109, 64),
                ),
                Options(
                  text: 'Outgoing',
                  color: Color.fromARGB(175, 255, 82, 82),
                ),
                Options(
                  text: 'Stats',
                  color: Color.fromARGB(151, 105, 240, 175),
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Top Products',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Icon(
                        Icons.menu,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 280,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TopProducts(
                          name: 'Egg',
                          price: '20',
                          desc: 'Lorem ipsum dolor sit amet, comsectetur',
                          image: 'assets/images/egg.png',
                        ),
                        TopProducts(
                          name: 'Horlicks',
                          price: '20',
                          desc: 'Lorem ipsum dolor sit amet, comsectetur',
                          image: 'assets/images/horlicks.png',
                        ),
                        TopProducts(
                          name: 'Real Juice',
                          price: '100',
                          desc: 'Lorem ipsum dolor sit amet, comsectetur',
                          image: 'assets/images/real (2).png',
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Overview',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Icon(
                    Icons.menu,
                  ),
                ],
              ),
            ),
            SizedBox(height: 200, width: 390, child: BarChartSample8()),
          ],
        ),
      ),
    ));
  }
}
