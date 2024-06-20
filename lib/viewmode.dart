import 'package:flutter/material.dart';
import 'package:youtube/api.dart';


class YouTubeViewModel extends ChangeNotifier {
  final YoutubeServices _apiService = YoutubeServices();
  List<Video> _videos = [];
  bool _isLoading = false;

  List<Video> get videos => _videos;
  bool get isLoading => _isLoading;

  Future<void> searchVideos(String query) async {
    _isLoading = true;
    notifyListeners();

    _videos = await _apiService.Searchvideos(query);
    _isLoading = false;
    notifyListeners();
  }
}
