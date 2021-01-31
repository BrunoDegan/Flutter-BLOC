import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:youtubebloc/app_widget.dart';
import 'package:youtubebloc/constants.dart';
import 'package:youtubebloc/modules/favorites/favorite_page.dart';
import 'modules/favorites/favorite_bloc.dart';
import 'modules/videos/videos_bloc.dart';
import 'modules/videos/videos_page.dart';

class AppModule extends MainModule {
  @override
  List<ModularRouter> get routers => [
        ModularRouter(HOME_PAGE, child: (context, args) => VideosPage()),
        ModularRouter(FAVORITES_PAGE, child: (context, args) => FavoritePage()),
      ];

  @override
  Widget get bootstrap => BaseAppWidget();

  @override
  List<Bind> get binds =>
      [Bind((i) => VideosBloc()), Bind((i) => FavoriteBloc())];
}
