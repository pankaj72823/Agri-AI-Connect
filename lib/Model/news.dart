class News {
  final String sourceId;
  final String sourceName;
  final String author;
  final String title;
  final String image;
  final String description;
  final String url;
  final String publishedAt;

  News({
    required this.sourceId,
    required this.sourceName,
    required this.author,
    required this.title,
    required this.image,
    required this.description,
    required this.url,
    required this.publishedAt,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      sourceId: json['source']['id'] ?? '',
      sourceName: json['source']['name'] ?? '',
      author: json['author'] ?? '',
      title: json['title'] ?? '',
      image: json['urlToImage'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      publishedAt: json['publishedAt'] ?? '',
    );
  }
}