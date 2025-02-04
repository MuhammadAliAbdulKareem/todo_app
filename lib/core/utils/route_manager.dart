import 'package:flutter/material.dart';
import 'package:todo_app/database_manager/model/todo_data_model.dart';
import 'package:todo_app/presentation/screens/home/home.dart';
import 'package:todo_app/presentation/screens/task_edit/task_editing.dart';

class RouteManager {
  static const String home = '/home';
  static const String taskEditing = '/taskEditing';

  static Route? router(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
        );
      case taskEditing:
        TaskDataModel task = settings.arguments as TaskDataModel;
        return MaterialPageRoute(
          builder: (context) => TaskEditing(
            task: task,
          ),
        );
    }
    return null;
  }
}
