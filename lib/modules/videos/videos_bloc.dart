import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:youtubebloc/api/api.dart';
import 'package:youtubebloc/models/video.dart';

class VideosBloc implements Disposable {

  API api;
  List<Video> videos;

  final StreamController<List<Video>> _videosController = StreamController<List<Video>>();
  Stream get outVideos => _videosController.stream;

  final StreamController<String> _searchController = StreamController<String>();
  Sink get inSearch => _searchController.sink;

  VideosBloc() {
    api = API();
    _searchController.stream.listen(_search);
  }

  void _search(String search) async {
    if (search != null) {
      _videosController.sink.add([]);
      videos = await api.search(search);
    } else {
      videos += await api.nextPage();
    }

    _videosController.sink.add(videos);
  }


  @override
  void dispose() {
    _videosController.close();
    _searchController.close();
  }
}