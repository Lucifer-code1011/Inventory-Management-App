// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:learn_flutter/pages/screens/profile.dart';
import 'package:page_transition/page_transition.dart';

import '../constants/constants.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0),
        child: Container(
          height: 56,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(padding, 0, padding, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Icon(
                            FluentIcons.options_16_regular,
                            color: black,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/icon.png',
                            height: 30,
                            width: 30,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Vision',
                            style: GoogleFonts.poppins(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    padding, padding, 0, padding),
                                child: Icon(
                                  IconlyLight.search,
                                  color: black,
                                ),
                              )),
                          SizedBox(
                            width: 20,
                          ),
                          GestureDetector(
                            onTap: () => Navigator.of(context).push(
                                PageTransition(
                                    child: const ProfileScreen(),
                                    type: PageTransitionType.fade)),
                            child: CircleAvatar(
                              radius: 15,
                              backgroundImage: NetworkImage(
                                user!.photoURL.toString(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
