import 'package:flutter/material.dart';
import 'package:todo_app/presentation/screens/home/home.dart';
import 'package:todo_app/presentation/screens/task_edit/task_editing.dart';

class RouteManager {
  static const String home = '/home';
  static const String splash = '/splash';
  static const String taskEditing = '/tastEditing';

  static Route? router(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
        );
      case taskEditing:
        return MaterialPageRoute(
          builder: (context) => const TaskEditing(),
        );
    }
    return null;
  }
}
