import 'package:flutter/material.dart';
import 'package:agri_ai_connect/Model/youtube_video.dart';
import 'package:url_launcher/url_launcher.dart';

class YouTubeVideoList extends StatelessWidget {
  Future<void> _launchURL(String url) async {

    if (await launchUrl( Uri.parse(url))) {
      await launchUrl( Uri.parse(url));
    } else {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Learning Videos'),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        itemCount: videoList.length,
        itemBuilder: (context, index) {
          final video = videoList[index];
          return Card(
            color: Colors.white,
            margin: EdgeInsets.all(10.0),
            elevation: 2.0,
            child: InkWell(
              onTap: () => _launchURL(video.url),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Image.network(
                      video.thumbnailUrl,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            video.name,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(video.time),
                          SizedBox(height: 5),
                          Text(
                            video.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.play_arrow,
                      size: 25,
                      color: Colors.green,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}