import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Text(
      //     'Agri AI Connect',
      //     style: TextStyle(
      //       color: Colors.black,
      //     ),
      //   ),
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   actions: [
      //     IconButton(
      //       icon: Icon(
      //         Icons.notifications,
      //         color: Colors.black,
      //       ),
      //       onPressed: () {},
      //     ),
      //   ],
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Welcome to Agri AI connect',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 200),
                child: Text(
                  'Our platform combines AI-powered tools, environmental incentives, crop data management, and educational resources to help you in your journey towards sustainable and profitable farming. Improve crop yield, reduce carbon footprint, manage your crops effectively, and enhance your knowledge and skills with us.',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),

              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  // Navigate to AI-based disease detection page
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange, // Button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  'AI Based  Crop Disease Detection',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: 16),
              Image.asset(
                'assets/splash/splash.jpg',
                // Replace with your image link
                height: 200,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.camera),
      //       label: 'Disease Detection',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.eco),
      //       label: ' Carbon Credits Marketplace',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: ' Home page',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.assessment),
      //       label: ' Crop data',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.school),
      //       label: 'Education Section',
      //     ),
      //   ],
      //   selectedItemColor: Colors.teal,
      //   unselectedItemColor: Colors.grey,
      //   showSelectedLabels: false,
      //   showUnselectedLabels: false,
      // ),
    );
  }
}


