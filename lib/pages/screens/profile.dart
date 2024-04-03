import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:iconly/iconly.dart';
import 'package:learn_flutter/constants/constants.dart';
import 'package:learn_flutter/pages/Login/signin.dart';
import 'package:learn_flutter/widgets/profileButton.dart';
import 'package:page_transition/page_transition.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(
              fontFamily: 'Gilmer',
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            IconlyLight.arrow_left,
            color: Colors.black,
          ),
        ),
        actions: [
          Padding(
            padding:
                const EdgeInsets.fromLTRB(padding, padding, padding, padding),
            child: InkWell(
              onTap: () {},
              child: Icon(
                FluentIcons.settings_16_regular,
                color: black,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          CircleAvatar(
            radius: 40,
            backgroundColor: black,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network(
                user!.photoURL.toString(),
              ),
            ),
          ),
          Container(
            height: 20,
            width: 80,
            child: Badge(
              backgroundColor: Color.fromARGB(200, 30, 30, 30),
              alignment: Alignment.topCenter,
              label: user!.displayName.toString() == 'Suman Pokhrel'
                  ? Text(
                      'Admin',
                      style: TextStyle(
                        fontFamily: 'Gilmer',
                        fontSize: 12,
                        color: white,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  : Text(
                      'Employee',
                      style: TextStyle(
                        fontFamily: 'Gilmer',
                        fontSize: 12,
                        color: white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            user!.displayName == null ? 'User' : user!.displayName.toString(),
            style: TextStyle(
              fontFamily: 'Gilmer',
              fontSize: 22,
              color: black,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            user!.email.toString(),
            style: TextStyle(
              fontFamily: 'Gilmer',
              fontSize: 14,
              color: lightGrey,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 45,
          ),
          MyProfileButton(
              text: 'Order History',
              color: lightBlack,
              textcolor: lightBlack,
              icon: FluentIcons.book_20_regular,
              backgroundcolor: whitesomke,
              onTap: () {}),
          const SizedBox(
            height: 15,
          ),
          MyProfileButton(
              text: 'Information',
              color: lightBlack,
              textcolor: lightBlack,
              icon: FluentIcons.location_16_regular,
              backgroundcolor: whitesomke,
              onTap: () {}),
          const SizedBox(
            height: 15.5,
          ),
          const Divider(
            color: Colors.grey,
            thickness: 0.5,
            indent: 30,
            endIndent: 30,
          ),
          const SizedBox(
            height: 15.5,
          ),
          MyProfileButton(
              text: 'Notifications',
              color: lightBlack,
              textcolor: lightBlack,
              icon: FluentIcons.alert_16_regular,
              backgroundcolor: whitesomke,
              onTap: () {}),
          const SizedBox(
            height: 15,
          ),
          MyProfileButton(
            text: 'Help and Support',
            color: lightBlack,
            textcolor: lightBlack,
            icon: FluentIcons.headphones_20_regular,
            onTap: () {},
            backgroundcolor: whitesomke,
          ),
          const SizedBox(
            height: 15,
          ),
          MyProfileButton(
            text: 'Log out',
            icon: FluentIcons.arrow_exit_20_regular,
            textcolor: white,
            color: white,
            backgroundcolor: const Color.fromARGB(140, 234, 25, 10),
            onTap: () async {
              showDialog(
                  context: context,
                  builder: (context) {
                    return Center(
                      child: CircularProgressIndicator(
                        semanticsLabel: 'Logging out',
                        color: black,
                        strokeWidth: 2.0,
                      ),
                    );
                  });

              await Future.delayed(const Duration(seconds: 4));
              Rx<GoogleSignInAccount?>(null).value =
                  await GoogleSignIn().signOut();
              // ignore: use_build_context_synchronously
              Navigator.of(context).push(PageTransition(
                  child: const SignIn(), type: PageTransitionType.fade));
            },
          ),
        ],
      ),
    );
  }
}
