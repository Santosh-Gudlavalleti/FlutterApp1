import 'package:acm1/apis/menu_services.dart';
import 'package:acm1/login/LOGIN.dart';
import 'package:flutter/material.dart';
//import 'package:acm1/views/gridsview.dart';
import 'package:get_it/get_it.dart';

import 'apis/menu_services.dart';

void setupLocator() {
  GetIt.instance.registerLazySingleton(() => MenuService());
}

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final title = 'Food Menu';

    return MaterialApp(
      //title: title,
      home: Login(),
    );
  }
}
