import 'package:flutter_modular/flutter_modular.dart';
import 'package:youtubebloc/constants.dart';
import 'package:youtubebloc/modules/favorites/favorite_page.dart';
import 'modules/favorites/favorite_bloc.dart';
import 'modules/videos/videos_bloc.dart';
import 'modules/videos/videos_page.dart';

class AppModule extends Module {
  @override
  List<ModularRoute> get routes => [
        ChildRoute(HOME_PAGE, child: (context, args) => VideosPage()),
        ChildRoute(FAVORITES_PAGE, child: (context, args) => FavoritePage()),
      ];

  @override
  List<Bind> get binds => [
        Bind.lazySingleton((i) => VideosBloc()),
        Bind.lazySingleton((i) => FavoriteBloc())
      ];
}
