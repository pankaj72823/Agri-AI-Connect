
import 'package:agri_ai_connect/Provider/disease_provider.dart';
import 'package:agri_ai_connect/Screens/disease_detection.dart';
import 'package:flutter/material.dart';

import 'agro_bot.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Welcome to Agri AI Connect',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 5,
                shadowColor: Colors.grey.withOpacity(0.7),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Our platform combines AI-powered tools, environmental incentives, crop data management, and educational resources to help you in your journey towards sustainable and profitable farming.',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Divider(
                        color: Colors.tealAccent,
                        thickness: 4,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Improve crop yield, reduce carbon footprint, manage your crops effectively, and enhance your knowledge and skills with us.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
               Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>DiseaseDetectionScreen(),
            ),
          );
        
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  shadowColor: Colors.orangeAccent,
                  elevation: 8,
                ),
                child: Text(
                  'AI Based Crop Disease Detection',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  'assets/splash/splash.jpg',
                  height: 220,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AgroBotScreen(),
            ),
          );
        },
        backgroundColor: Colors.red[400],
        child: Image.asset(
          'assets/intial_img/Chatbot1.png', // Replace with the correct path to your chatbot image
          height: 70,
          width: 70,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
