import 'package:cloud_firestore/cloud_firestore.dart';

class TaskDataModel {
  static const String collectionName = 'todo';
  String id;
  String title;
  String description;
  DateTime dateTime;
  bool status;

  TaskDataModel(
      {this.id = '',
      required this.title,
      required this.description,
      required this.dateTime,
      this.status = false});

  Map<String, dynamic> toFireStore() => {
        'id': id,
        'title': title,
        'description': description,
        'date': Timestamp.fromDate(dateTime),
        'status': status,
      };

  factory TaskDataModel.fromFireStore(Map<String, dynamic> taskData) =>
      TaskDataModel(
          id: taskData['id'],
          title: taskData['title'],
          description: taskData['description'],
          dateTime: (taskData['date'] as Timestamp).toDate(),
          // dateTime: taskData['date'].toDate(),
          status: taskData['status']);
  // TaskDataModel.fromFireStore(Map<String, dynamic> taskData)
  //     : this(
  //           id: taskData['id'],
  //           title: taskData['title'],
  //           description: taskData['description'],
  //           dateTime: taskData['date'].toDate(),
  //           status: taskData['status']
  //           );
}
