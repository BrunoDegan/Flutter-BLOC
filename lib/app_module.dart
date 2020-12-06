import 'package:flutter_modular/flutter_modular.dart';
import 'package:youtubebloc/app_widget.dart';
import 'modules/app_bloc.dart';
import 'modules/favorites/favorite_module.dart';
import 'modules/home/home_module.dart';
import 'modules/videos/videos_module.dart';

class AppModule extends MainModule {
  static Inject get to => Inject<AppModule>.of();

  @override
  List<Bind> get binds => [Bind((i) => AppBloc())];

  @override
  List<Router> get routers => [
        Router('/', module: HomeModule()),
        Router('/favorites', module: FavoriteModule()),
        Router('/videos', module: VideosModule())
      ];

  @override
  Widget get bootstrap => throw BaseAppWidget();
}
