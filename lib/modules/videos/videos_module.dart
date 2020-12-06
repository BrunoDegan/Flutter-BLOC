import 'package:flutter_modular/flutter_modular.dart';
import 'videos_bloc.dart';
import 'videos_page.dart';

class VideosModule extends ChildModule {

  static Inject get to => Inject<VideosModule>.of();

  @override
  List<Bind> get binds => [
    Bind((i) => VideosBloc()),
  ];

  @override
  List<Router> get routers => [
    Router("/videos", child: (context,args) => VideosPage())

  ];
}