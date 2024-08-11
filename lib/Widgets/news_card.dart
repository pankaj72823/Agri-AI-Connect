import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Model/news.dart';

class NewsCard extends StatelessWidget {
  final News news;

  NewsCard({required this.news});

  void _launchURL(String url) async {
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url, mode: LaunchMode.inAppWebView)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          news.image.isNotEmpty ? Image.network(news.image) : SizedBox.shrink(),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              news.title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'By ${news.author}',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              news.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Published At: ${news.publishedAt}',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: ElevatedButton(
              onPressed: () => _launchURL(news.url),
              child: Text('Read More'),
            ),
          ),
        ],
      ),
    );
  }
}