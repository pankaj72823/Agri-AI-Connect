import 'dart:async';
import 'package:agri_ai_connect/Screens/login.dart';
import 'package:agri_ai_connect/Screens/signup.dart';
import 'package:flutter/material.dart';

class ImageSliding extends StatefulWidget {
  @override
  _ImageSlidingState createState() => _ImageSlidingState();
}

class _ImageSlidingState extends State<ImageSliding> {
  PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 2), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
        _pageController.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      } else {
        _timer?.cancel(); // Stop the timer when the last image is reached
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[500],
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: [
              Image.asset('assets/intial_img/i1.jpg', fit: BoxFit.contain),
              Image.asset('assets/intial_img/i3.jpg', fit: BoxFit.contain),
              Image.asset('assets/intial_img/i2.jpg', fit: BoxFit.contain),
            ],
          ),
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: _currentPage == 2
                ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context, MaterialPageRoute(
                        builder: (ctx) => Login(),
                      )
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor:
                      Color.fromARGB(255, 29, 83, 31), // Text color
                      padding: EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 12.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text('Login'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context, MaterialPageRoute(
                        builder: (ctx) => Signup(),
                      )
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor:
                      Color.fromARGB(255, 29, 83, 31), // Text color
                      padding: EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 12.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text('Signup'),
                  ),
                ],
              ),
            )
                : SizedBox.shrink(), // Hide buttons on other pages
          ),
        ],
      ),
    );
  }
}