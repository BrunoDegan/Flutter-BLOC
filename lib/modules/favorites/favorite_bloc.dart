import 'dart:async';
import 'dart:convert';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtubebloc/models/video.dart';
import '../../constants.dart';

class FavoriteBloc extends Disposable {
  Map<String, Video> _favorites = {};

  final StreamController<Map<String, Video>> _favController =
      BehaviorSubject<Map<String, Video>>();
  Stream<Map<String, Video>> get ouFav => _favController.stream;

  FavoriteBloc() {
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.getKeys().contains("favorites")) {
        _favorites =
            json.decode(prefs.getString("favorites")).map((key, value) {
          return MapEntry(key, Video.fromJson(value));
        }).cast<String, Video>();

        _favController.add(_favorites);
      }
    });
  }

  void toggleFavorite(Video video) {
    if (_favorites.containsKey(video.id)) {
      _favorites.remove(video.id);
    } else {
      if (video.id != null) _favorites[video.id] = video;
    }

    _favController.sink.add(_favorites);

    _saveFavorite();
  }

  void _saveFavorite() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString(FAVORITES_PAGE, json.encode(_favorites));
    });
  }

  @override
  void dispose() {
    _favController.close();
  }
}
