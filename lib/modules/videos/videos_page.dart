import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:youtubebloc/constants.dart';
import 'package:youtubebloc/delegates/data_search.dart';
import 'package:youtubebloc/models/video.dart';
import 'package:youtubebloc/modules/favorites/favorite_bloc.dart';
import 'package:youtubebloc/modules/videos/videos_bloc.dart';
import 'package:youtubebloc/widgets/video_tile.dart';

class VideosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _videosBloc = Modular.get<VideosBloc>();
    final _favoriteBloc = Modular.get<FavoriteBloc>();

    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 25,
          child: Image.asset("images/yt_logo_rgb_dark.png"),
        ),
        elevation: 0,
        backgroundColor: Colors.black87,
        actions: <Widget>[
          Align(
            alignment: Alignment.center,
            child: StreamBuilder<Map<String, Video>>(
                stream: _favoriteBloc.ouFav,
                builder: (context, snapshot) {
                  if (snapshot.hasData)
                    return Text("${snapshot.data?.length}");
                  else
                    return Container();
                }),
          ),
          IconButton(
            icon: Icon(Icons.star),
            onPressed: () {
              Modular.to.pushNamed(FAVORITES_PAGE);
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              String result = await showSearch(
                      context: context, delegate: DataSearchAPI()) ??
                  "";
              _videosBloc.inSearch.add(result);
            },
          )
        ],
      ),
      backgroundColor: Colors.black87,
      body: StreamBuilder(
          stream: _videosBloc.outVideos,
          initialData: [],
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  if (index < snapshot.data.length) {
                    return VideoTile(snapshot.data[index]);
                  } else if (index > 1) {
                    _videosBloc.inSearch.add(null);
                    return Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
                itemCount: snapshot.data.length + 1,
              );
            } else {
              return Container();
            }
          }),
    );
  }
}
