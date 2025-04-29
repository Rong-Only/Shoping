// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:demo_interview/Views/card.dart';
import 'package:demo_interview/Views/favorite.dart';
import 'package:demo_interview/Views/home.dart';
import 'package:demo_interview/Views/Store.dart';
import 'package:demo_interview/Views/menu.dart';
import 'package:demo_interview/Views/signin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const Home(),
    const Favorite(), // Use the widget directly instead of navigation
    const Store(), // Use the widget directly instead of navigation
    const CheckOut(), // Use the widget directly instead of navigation
    const menu(),
  ];

  void navigateToFavorite(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Favorite()),
    );
  }

  void navigateToStore(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Store()),
    );
  }

  void navigateToCard(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CheckOut()),
    );
  }

  void navigateToProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const menu()),
    );
  }
}

class THelperFunctions {
  static bool isDarkMode(BuildContext context) {
    // Example logic, you may need to customize this based on your app's theme
    return Theme.of(context).brightness == Brightness.dark;
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Signin(),
    );
  }
}

class MainScreen extends StatelessWidget {
  final NavigationController controller = Get.put(NavigationController());

  MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: Text(
          "SHOPING",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 227, 207, 54),
        elevation: 0,
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 15),
              child: IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    'icons/bell.png',
                    height: 30,
                    width: 30,
                  )))
        ],
      ),
      body: Obx(
        () => controller.screens[controller.selectedIndex.value],
      ),
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 85,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) {
            controller.selectedIndex.value = index; // Update the selected index
          },
          backgroundColor: darkMode ? Colors.black : Colors.white,
          indicatorColor: darkMode
              ? Colors.white.withOpacity(0.1)
              : Colors.black.withOpacity(0.1),
          destinations: [
            NavigationDestination(
                icon: Image.asset(
                  "icons/home.png",
                  height: 25,
                  width: 25,
                ),
                label: 'Home'),
            NavigationDestination(
                icon: Image.asset(
                  "icons/heart.png",
                  height: 25,
                  width: 25,
                ),
                label: 'Favorite'),
            NavigationDestination(
                icon: Image.asset(
                  "icons/shopping-cart.png",
                  height: 25,
                  width: 25,
                ),
                label: 'Store'),
            NavigationDestination(
                icon: Image.asset(
                  "icons/checkout.png",
                  height: 25,
                  width: 25,
                ),
                label: 'Card'),
            NavigationDestination(
                icon: Image.asset(
                  "icons/menu.png",
                  height: 25,
                  width: 25,
                ),
                label: 'Menu'),
          ],
        ),
      ),
    );
  }
}
