import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:radio_javan/ui/screens/category_screen.dart';
import 'package:radio_javan/ui/screens/favorite_screen.dart';

import 'hoem_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int currentItem = 0;
  List<Widget> bodyScreens = [
    const HomeScreen(),
    const CategoryScreen(),
    const FavoriteScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text('Radio Javan'),
        centerTitle: true,
      ),
      body: bodyScreens.elementAt(currentItem),
      extendBody: true,
      bottomNavigationBar: SizedBox(
        height: 138,
        child: FloatingNavbar(
          selectedItemColor: Colors.blue,
          items: [
            FloatingNavbarItem(icon: Icons.home, title: 'Home'),
            FloatingNavbarItem(icon: Icons.category, title: 'Category'),
            FloatingNavbarItem(icon: Icons.favorite, title: 'Favorite'),
          ],
          currentIndex: currentItem,
          onTap: (value) {
            setState(() {
              // throw Exception();
              currentItem = value;
            });
          },
        ),
      ),
    );
  }
}
