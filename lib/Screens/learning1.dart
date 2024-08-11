import 'package:agri_ai_connect/Screens/learning_videos.dart';
import 'package:agri_ai_connect/Screens/news_videos.dart';
import 'package:flutter/material.dart';

class learning1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Align(alignment: Alignment.center,
            child: Text('Information for Farmers',
              style: TextStyle(color: Colors.teal[700], fontSize: 24, fontWeight: FontWeight.bold),
            ),

        ),
        // backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Network Image 1: Agriculture Field

            // Network Image 2: Farmer Working
            Container(
              margin: const EdgeInsets.only(bottom: 24.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.network(
                  'https://static.teamviewer.com/resources/2020/04/farmer-holding-tablet-smart-arm-robot-1620x1080.jpg', // Replace with actual URL
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Button 1: Agriculture News
            ElevatedButton(
              onPressed: () =>  Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => NewsScreen(),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange, // Button color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.article, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    'Agriculture News',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            // Button 2: Learning Videos
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => YouTubeVideoList(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal, // Button color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.video_library, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    'Learning Videos',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}