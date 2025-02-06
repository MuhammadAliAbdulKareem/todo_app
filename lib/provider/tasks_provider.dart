import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_app/core/remote/firebase_services.dart';
import 'package:todo_app/core/utils/extensions/date_format.dart';
import 'package:todo_app/database_manager/model/todo_data_model.dart';

class TasksProvider with ChangeNotifier {
  List<TaskDataModel> allTasks = [];
  DateTime selectedDate = DateTime.now();
  void changeSelectedDate(DateTime newSelectedDate) async {
    selectedDate = newSelectedDate;
    await getTasksByDateFromFireStore();
  }

  Future<void> getTasksByDateFromFireStore() async {
    try {
      allTasks = await FirebaseServices.getTasksByDate(
        DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          // selectedDate.hour,
          // selectedDate.minute,
        ),
      );
      Fluttertoast.showToast(
        msg: "All Task in ${selectedDate.dateFormatter}  has been gotten",
        backgroundColor: Colors.green,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        toastLength: Toast.LENGTH_SHORT,
      );
      notifyListeners();
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error : ${e.toString()}",
        backgroundColor: Colors.red,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }

  Future<void> addTaskToFireStore(TaskDataModel newTask) async {
    try {
      await FirebaseServices.addTask(newTask)
          .timeout(const Duration(seconds: 3), onTimeout: () async {
        await getTasksByDateFromFireStore();
      });

      Fluttertoast.showToast(
        msg: 'Task Added Successfully',
        backgroundColor: Colors.green,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_SHORT,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error : ${e.toString()}",
        backgroundColor: Colors.red,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }

  Future<void> updateTaskFromFireStore(TaskDataModel? task) async {
    if (task == null) return;

    try {
      await FirebaseServices.updateTask(task);
      await getTasksByDateFromFireStore();
      // .then((_) {
      //   if (context.mounted) {
      //     Navigator.pop(context, true);
      //   }
      // })
      // .onError((error, stackTrace) {})
      // .timeout(const Duration(seconds: 5), onTimeout: () {
      //   if (context.mounted) {
      //     Navigator.pop(context, true);
      //   }
      // });
      Fluttertoast.showToast(
        msg: "Task Updated Successfully",
        backgroundColor: Colors.green,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_SHORT,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error : ${e.toString()}",
        backgroundColor: Colors.red,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }

  Future<void> deleteTaskFromFireStore(TaskDataModel task) async {
    try {
      await FirebaseServices.deleteTask(task.id);
      await getTasksByDateFromFireStore();
      Fluttertoast.showToast(
        msg: "Task Deleted Successfully",
        backgroundColor: Colors.green,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        toastLength: Toast.LENGTH_LONG,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error : ${e.toString()}",
        backgroundColor: Colors.red,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }
}
