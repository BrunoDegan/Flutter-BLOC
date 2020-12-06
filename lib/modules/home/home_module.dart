import 'package:flutter_modular/flutter_modular.dart';
import 'package:youtubebloc/modules/videos/videos_bloc.dart';
import 'home_page.dart';

class HomeModule extends ChildModule {

  static Inject get to => Inject<HomeModule>.of();

  @override
  List<Bind> get binds => [
    Bind((i) => VideosBloc())
  ];

  @override
  List<Router> get routers => [
    Router("/", child: (context, args) => HomePage())
  ];
}
