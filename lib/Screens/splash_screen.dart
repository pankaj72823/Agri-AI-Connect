// import 'package:agri_ai_connect/Screens/image_sliding.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to the next screen after 3 seconds
    Future.delayed(Duration(seconds: 3), () {
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => ImageSliding()),
      // );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green, // Set your background color here
      body: Center(
        child: Container(
          width: 300, // Set the desired width for the logo
          height: 300, // Set the desired height for the logo
          child: Image.asset('assets/splash/logo.png'), // Display your logo
        ),
      ),
    );
  }
}