import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:youtubebloc/models/video.dart';

const API_KEY = "AIzaSyCX5f-kF8uUqGIsjjomi-ObIejZIYK4cVo";

//const URI2= "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_search&type=video&key=$API_KEY&maxResults=10&pageToken=$_nextToken"
//const URI3 = "http://suggestqueries.google.com/complete/search?hl=en&ds=yt&client=youtube&hjson=t&cp=1&q=$search&format=5&alt=json"

class API {

  String _nextToken;
  String _search;

  Future<List<Video>> search (String search) async {
    _search = search;
    var resultsLen = 10;
    http.Response response = await http.get(
        "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_search&type=video&key=$API_KEY&maxResults=${resultsLen.toString()}");
    return decode(response);
  }

  Future<List<Video>> nextPage() async {
    var resultsLen = 10;
    http.Response response = await http.get("https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_search&type=video&key=$API_KEY&maxResults=${resultsLen.toString()}&pageToken=$_nextToken");
  }

  List<Video> decode(http.Response response) {
    if (response.statusCode == 200) {
      var decoded = json.decode(response.body);

      _nextToken = decoded["nextPageToken"];

      List<Video> videos = decoded["items"].map<Video>((map) {
        Video.fromJson(map);
      }).toList();

      return videos;
    } else {
      throw Exception("Failed to load videos!");
    }
  }
}
