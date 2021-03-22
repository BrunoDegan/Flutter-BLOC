import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'constants.dart';

class BaseAppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HOME_PAGE,
    ).modular();
  }
}
