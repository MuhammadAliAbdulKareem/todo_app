import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/database_manager/model/todo_data_model.dart';

class FirebaseServices {
  static CollectionReference<TaskDataModel> getTasksCollection() =>
      FirebaseFirestore.instance
          .collection(TaskDataModel.collectionName)
          .withConverter<TaskDataModel>(
              fromFirestore: (snapshot, _) =>
                  TaskDataModel.fromFireStore(snapshot.data() ?? {}),
              toFirestore: (value, _) => value.toFireStore());
  static Future<void> addTask(TaskDataModel task) {
    CollectionReference<TaskDataModel> tasksCollection = getTasksCollection();
    DocumentReference taskDocument = tasksCollection.doc();
    task.id = taskDocument.id;
    return taskDocument.set(task);
  }

  static Future<void> deleteTask(String taskId) {
    CollectionReference<TaskDataModel> collectionReference =
        getTasksCollection();
    return collectionReference.doc(taskId).delete();
  }

  static Future<void> updateTask(TaskDataModel task) async {
    CollectionReference<TaskDataModel> tasksCollection = getTasksCollection();
    DocumentReference taskDoc = tasksCollection.doc(task.id);
    return await taskDoc.update(task.toFireStore());
  }

  static Future<List<TaskDataModel>> getTasksByDate(
      DateTime selectedDate) async {
    CollectionReference<TaskDataModel> tasksCollection = getTasksCollection();
    QuerySnapshot<TaskDataModel> tasksQuery = await tasksCollection
        .where('date', isEqualTo: Timestamp.fromDate(selectedDate))
        .get();
    return tasksQuery.docs.map((task) => task.data()).toList();
  }
}
