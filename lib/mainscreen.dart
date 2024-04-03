import 'dart:convert';
import 'dart:io' as Platform;
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:learn_flutter/pages/screens/homepage.dart';
import 'package:learn_flutter/pages/screens/product_form.dart';
import 'package:learn_flutter/pages/screens/products.dart';
import 'package:learn_flutter/pages/screens/profile.dart';
import 'package:learn_flutter/pages/screens/scan.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  int selectedIndex = 0;
  List<Map<String, dynamic>> items = [];
  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Future<void> saveJsonData(List<Map<String, dynamic>> productList) async {
    try {
      final Map<String, dynamic> jsonData = {'products': productList};
      final String jsonString = json.encode(jsonData);

      const String filePath = 'assets/files/catalog.json';
      await Platform.File(filePath).writeAsString(jsonString);
    } catch (e) {
      print('Error saving JSON data: $e');
    }
  }

  static final List<Widget> _pages = <Widget>[
    const HomeScreen(),
    const MyProducts(),
    const ObjectDetectionPage(),
    const ProductForm(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages.elementAt(selectedIndex),
      ),
      bottomNavigationBar: Padding(
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
                icon: const Icon(IconlyLight.scan),
              ),
              CustomNavigationBarItem(
                icon: const Icon(IconlyLight.paper),
              ),
              CustomNavigationBarItem(
                icon: const Icon(IconlyLight.user),
              ),
            ],
            isFloating: true,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
