import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';

class MyBottomNavBar extends StatelessWidget {
  final dynamic Function(int)? onItemTapped;
  final int selectedIndex;
  final bool hasItem;
  const MyBottomNavBar({
    super.key,
    required this.onItemTapped,
    required this.selectedIndex,
    required this.hasItem,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: SizedBox(
        height: 70,
        child: CustomNavigationBar(
          elevation: 0,
          borderRadius: const Radius.circular(25),
          iconSize: 23.0,
          selectedColor: Colors.deepPurpleAccent,
          currentIndex: selectedIndex,
          strokeColor: Colors.white,
          unSelectedColor: const Color.fromARGB(255, 95, 95, 95),
          backgroundColor: Colors.black87,
          items: [
            CustomNavigationBarItem(
              icon: const Icon(IconlyLight.home),
            ),
            CustomNavigationBarItem(
              icon: const Icon(IconlyLight.search),
            ),
            CustomNavigationBarItem(
              icon: const Icon(IconlyLight.bag_2),
            ),
            CustomNavigationBarItem(
              icon: const Icon(IconlyLight.notification),
            ),
            CustomNavigationBarItem(
              icon: const Icon(IconlyLight.user),
            ),
          ],
          isFloating: true,
          onTap: onItemTapped,
        ),
      ),
    );
  }
}
