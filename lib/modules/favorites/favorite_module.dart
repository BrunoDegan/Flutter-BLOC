import 'package:flutter_modular/flutter_modular.dart';
import 'package:youtubebloc/modules/favorites/favorite_bloc.dart';
import 'favorite_page.dart';

class FavoriteModule extends ChildModule {

  static Inject get to => Inject<FavoriteModule>.of();

  @override
  List<Bind> get binds => [
    Bind((i) => FavoriteBloc()),
  ];

  @override
  List<Router> get routers => [
    Router("/favorites", child: (context, args) => FavoritePage())
  ];
}
