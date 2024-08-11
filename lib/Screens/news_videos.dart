
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Model/news.dart';
import '../Widgets/news_card.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}


class _NewsScreenState extends State<NewsScreen> {
  List<News> _news = [];

  @override
  void initState() {
    super.initState();
    _getNewsData();
  }

  Future<void> _getNewsData() async {
    final apiKey = "ff0e452b2a784f6b9d186a1210c914c2";
    final urlString =
        "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=$apiKey";

    final uri = Uri.parse(urlString);
    final newsResponse = await http.get(uri);

    if (newsResponse.statusCode == 200) {
      final jsonData = json.decode(newsResponse.body);
      if (jsonData['articles'] != null) {
        final articles = jsonData['articles'] as List<dynamic>;
        setState(() {
          _news = articles.map((json) => News.fromJson(json)).toList();
        });
      } else {
        throw Exception('No articles found in the response');
      }
    } else {
      throw Exception('Failed to load news');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 202, 242, 203),
      appBar: AppBar(
        title: Text('News'),
        backgroundColor: Colors.green,
      ),
      body: _news.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _news.length,
        itemBuilder: (context, index) {
          return NewsCard(news: _news[index]);
        },
      ),
    );
  }
}