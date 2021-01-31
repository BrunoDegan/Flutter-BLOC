import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:youtubebloc/models/video.dart';
import 'package:youtubebloc/modules/favorites/favorite_bloc.dart';
import '../../constants.dart';

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _bloc = Modular.get<FavoriteBloc>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Favoritos"),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      backgroundColor: Colors.black87,
      body: StreamBuilder<Map<String, Video>>(
          stream: _bloc.ouFav,
          initialData: {},
          builder: (context, snapshot) {
            return ListView(
              children: snapshot.data.values.map((video) {
                return InkWell(
                  onTap: () {
                    FlutterYoutube.playYoutubeVideoById(
                        apiKey: API_KEY, videoId: video.id);
                  },
                  onLongPress: () {
                    _bloc.toggleFavorite(video);
                  },
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 100,
                        height: 50,
                        child: Image.network(video.thumb),
                      ),
                      Expanded(
                        child: Text(
                          video.title,
                          style: TextStyle(color: Colors.white70),
                          maxLines: 2,
                        ),
                      )
                    ],
                  ),
                );
              }).toList(),
            );
          }),
    );
  }
}
