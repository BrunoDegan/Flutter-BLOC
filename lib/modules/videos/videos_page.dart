import 'package:flutter/material.dart';
import 'package:youtubebloc/modules/videos/videos_bloc.dart';
import 'package:youtubebloc/modules/videos/videos_module.dart';

class VideosPage extends StatelessWidget{

  final bloc = VideosModule.to.get<VideosBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

}