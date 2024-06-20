import 'dart:convert';
import 'package:http/http.dart' as http;

class YoutubeServices {
  final String apikey =
      '6c85fbfd79fdcabfe8b5366842b277c39501f6eabded41ad96ceda658b200efc';

  Future<List<Video>> Searchvideos(String query) async {
    final response = await http.get(Uri.parse(
        'https://serpapi.com/search.json?engine=youtube&search_query=$query&api_key=$apikey'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<Video> videos = [];
      for (var item in data['video_results']) {
        videos.add(Video.fromJson(item));
      }
      return videos;
    } else {
      throw Exception('Failed to load videos');
    }
  }
}

class Video {
  final String title;
  final String thumbnailUrl;
  final String link;
  final String channelName;
  final String channelLink;
  final String description;
  final String length;
  final int watching;
  final bool live;

  Video({
    required this.title,
    required this.thumbnailUrl,
    required this.link,
    required this.channelName,
    required this.channelLink,
    required this.description,
    required this.length,
    required this.watching,
    required this.live,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      title: json['title'] ?? '',
      thumbnailUrl: json['thumbnail']?['static'] ?? '',
      link: json['link'] ?? '',
      channelName: json['channel']?['name'] ?? '',
      channelLink: json['channel']?['link'] ?? '',
      description: json['description'] ?? '',
      length: json['length'] ?? '',
      watching: json['watching'] ?? 0,
      live: json['live'] ?? false,
    );
  }
}

// void main() async {
//   YoutubeServices youtubeServices = YoutubeServices();
//   try {
//     List<Video> videos = await youtubeServices.Searchvideos('Coffee');
//     for (var video in videos) {
//       print('Title: ${video.title}');
//       print('Thumbnail URL: ${video.thumbnailUrl}');
//       print('Link: ${video.link}');
//       print('Channel Name: ${video.channelName}');
//       print('Channel Link: ${video.channelLink}');
//       print('Description: ${video.description}');
//       print('Length: ${video.length}');
//       print('Watching: ${video.watching}');
//       print('Live: ${video.live}');
//       print('---');
//     }
//   } catch (e) {
//     print(e);
//   }
// }
