import 'package:flutter/material.dart';
import 'package:youtubebloc/models/video.dart';
import 'package:youtubebloc/modules/home/home_module.dart';
import 'package:youtubebloc/modules/videos/videos_bloc.dart';
import 'package:youtubebloc/delegates/data_search.dart';
import 'package:youtubebloc/widgets/video_tile.dart';

class HomePage extends StatelessWidget {

  final videosBloc = HomeModule.to.get<VideosBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Container(
          height: 25,
          child: Image.asset("images/yt_logo_rgb_dark.png"),
        ),
        elevation: 6,
        backgroundColor: Colors.black87,
        actions: <Widget>[
          Align(
            alignment: Alignment.center,
            child: StreamBuilder<Map<String, Video>>(
                stream: videosBloc.outVideos,
                initialData: {},
                builder: (context, snapshot) {
                  if(snapshot.hasData)
                    return Text("${snapshot.data.length}");
                  else
                    return Container();
                }),
          ),
          IconButton(
            icon: Icon(Icons.star),
            onPressed: () {

            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              String result =
              await showSearch(context: context, delegate: DataSearchAPI());
              if (result != null)
                videosBloc.inSearch.add(result);
            },
          ),
        ],
      ),
      body: StreamBuilder(
          stream: videosBloc.outVideos,
          initialData: [],
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  if (index < snapshot.data.length) {
                    return VideoTile(snapshot.data[index]);
                  } else if (index > 1) {
                    videosBloc.inSearch.add(null);
                    return Container(
                      width: 40,
                      height: 40,
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
