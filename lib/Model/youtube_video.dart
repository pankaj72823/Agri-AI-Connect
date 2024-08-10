class YouTubeVideo {
  final String name;
  final String time;
  final String description;
  final String url;

  YouTubeVideo({
    required this.name,
    required this.time,
    required this.description,
    required this.url,
  });

  // Method to get the video ID from the YouTube URL
  String get videoId {
    final uri = Uri.parse(url);
    return uri.queryParameters['v'] ?? uri.pathSegments.last;
  }

  // Method to get the thumbnail URL
  String get thumbnailUrl => 'https://img.youtube.com/vi/$videoId/0.jpg';
}

final List<YouTubeVideo> videoList = [
  YouTubeVideo(
    name: 'Cucumber Harvesting',
    time: '08:47',
    description: 'How to grow the 69 millions of the cucumber',
    url: 'https://youtu.be/OzGudoy7keA?feature=shared',
  ),
  YouTubeVideo(
    name: 'Agriculture Technology',
    time: '11:45',
    description: 'Mordern Agriculuture technology - Broccoli,cabbage',
    url: 'https://youtu.be/l0bpy857deM?feature=shared',
  ),
  YouTubeVideo(
    name: 'American Agriculture Technology',
    time: '8:06',
    description: 'Harvest Billions of Tomatoes in Califonia',
    url: 'https://youtu.be/C-d5_qLX6FE?feature=shared',
  ),
  YouTubeVideo(
    name: 'Harvest Pounds of Fruits and Vegetables',
    time: '17:29',
    description:
    'American farmers Harvest Billions Pounds of Fruits and Vegetables',
    url: 'https://youtu.be/hC4lemk_YqE?feature=shared',
  ),
  YouTubeVideo(
    name: 'CropBioLife',
    time: '0:39',
    description: 'Fertilizer Enhancer, make your fertilizer go further',
    url: 'https://youtu.be/Qfozqrom7Bk?feature=shared',
  ),
  YouTubeVideo(
    name: 'Corn Farming',
    time: '18:09',
    description: 'Logistic behind the Crop Farming',
    url: 'https://youtu.be/R9pxFgJwxFE?feature=shared',
  ),
  YouTubeVideo(
    name: 'Start A small Farm',
    time: '17:57',
    description: 'How to start a small farm step-by-step guide',
    url: 'https://youtu.be/heTxEsrPVdQ?feature=shared',
  ),
  YouTubeVideo(
    name: 'Safforn Farming',
    time: '21:52',
    description: 'Safforn farming in the shiping containers.',
    url: 'https://youtu.be/vnhg_zT7OiM?feature=shared',
  ),
  YouTubeVideo(
    name: 'Pomegranates Harvest',
    time: '8:32',
    description:
    'Harvest and process the hundreds of tons of the pomegranates.',
    url: 'https://youtu.be/GM9HUHaw8Wk?feature=shared',
  ),
  YouTubeVideo(
    name: 'Chicken Farming',
    time: '11:42',
    description: 'How to raise Millions of free Range Chicken for eggs',
    url: 'https://youtu.be/A6osRIjenQg?feature=shared',
  ),
];