import 'package:agri_ai_connect/Screens/carbon_credits_join.dart';
import 'package:agri_ai_connect/Screens/disease_detection.dart';
import 'package:agri_ai_connect/Screens/home_page.dart';
import 'package:agri_ai_connect/Screens/learning1.dart';
import 'package:agri_ai_connect/Screens/profile_screen.dart';
import 'package:agri_ai_connect/Screens/weather_forecast.dart';
import 'package:flutter/material.dart';

import 'crop_data.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int currentIndex = 0;

  final List<Widget> screens = [
    HomePage(),
    const DiseaseDetectionScreen(),
    const CarbonCreditsJoin(),
    CropData(),
    learning1(),
  ];

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.greenAccent.withOpacity(0.7),
        title: const Text(
          'Agri AI Connect',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ProfileScreen(),
            ),
          ),
          icon: const Icon(
            Icons.person,
            size: 35,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WeatherScreen(),
              ),
            ),
            icon: const Icon(
              Icons.notifications,
              size: 35,
            ),
          ),
        ],
      ),
      body: screens[currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          onTabTapped(0);
        },
        child: const Icon(Icons.home),
        backgroundColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.greenAccent.withOpacity(0.7),
        shape: const CircularNotchedRectangle(),
        notchMargin: 7.0,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                onTabTapped(1);
              },
              icon: const Icon(Icons.camera),
            ),
            IconButton(
              onPressed: () {
                onTabTapped(2);
              },
              icon: const Icon(Icons.eco),
            ),
            const SizedBox(width: 48), // Spacer for FAB
            IconButton(
              onPressed: () {
                onTabTapped(3);
              },
              icon: const Icon(Icons.assessment),
            ),
            IconButton(
              onPressed: () {
                onTabTapped(4);
              },
              icon: const Icon(Icons.school),
            ),
          ],
        ),
      ),
    );
  }
}
