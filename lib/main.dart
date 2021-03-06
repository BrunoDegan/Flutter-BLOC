import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:youtubebloc/app_module.dart';
import 'package:youtubebloc/app_widget.dart';

void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  runApp(ModularApp(
    module: AppModule(),
    child: BaseAppWidget(),
  ));
}
