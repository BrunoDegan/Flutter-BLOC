import 'dart:convert';
import 'package:youtubebloc/constants.dart';
import 'package:http/http.dart' as http;
import 'package:youtubebloc/models/video.dart';

class API {
  String _nextToken = "";
  String _search = "";
  String _resultsLen = "10";

  Future<List<Video>> search(String search) async {
    _search = search;
    http.Response response = await http.get(Uri.parse(
        "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_search&type=video&key=$API_KEY&maxResults=$_resultsLen"));
    return decode(response);
  }

  Future<List<Video>> nextPage() async {
    http.Response response = await http.get(Uri.parse(
        "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_search&type=video&key=$API_KEY&maxResults=$_resultsLen&pageToken=$_nextToken"));
    return decode(response);
  }

  List<Video> decode(http.Response response) {
    if (response.statusCode == 200) {
      var decoded = json.decode(response.body);

      List<Video> videos =
          decoded["items"].map<Video>((map) => Video.fromJson(map)).toList();

      _nextToken = decoded["nextPageToken"];

      return videos;
    } else {
      throw Exception("Failed to load videos!");
    }
  }
}
