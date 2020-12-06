import 'package:flutter/material.dart';
import 'package:youtubebloc/modules/favorites/favorite_bloc.dart';
import 'package:youtubebloc/modules/favorites/favorite_module.dart';

class FavoritePage extends StatelessWidget{

  final bloc = FavoriteModule.to.get<FavoriteBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

}