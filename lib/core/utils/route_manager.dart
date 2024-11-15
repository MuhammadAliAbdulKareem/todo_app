import 'package:flutter/material.dart';
import 'package:todo_app/presentation/screens/home/home.dart';

class RouteManager {
  static const String home = '/home';
  static const String splash = '/splash';

  static Route? router(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
        );
    }
    return null;
  }
}
