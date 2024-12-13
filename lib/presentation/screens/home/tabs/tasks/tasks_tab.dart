import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/utils/app_styles.dart';
import 'package:todo_app/core/utils/colors_manager.dart';
import 'package:todo_app/core/utils/extensions/date_format.dart';
import 'package:todo_app/database_manager/model/todo_data_model.dart';
import 'package:todo_app/presentation/screens/home/tabs/tasks/task_item/task_item_widget.dart';

class TasksTab extends StatefulWidget {
  TasksTab({super.key});
  List<TaskDataModel> tasksList = [];

  @override
  State<TasksTab> createState() => TasksTabState();
}

class TasksTabState extends State<TasksTab> {
  DateTime calenderSelectedDate = DateTime.now();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTasksFromFireStore();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              color: ColorsManager.blue,
              height: 70.0.h,
            ),
            buildCalender(),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: widget.tasksList.length,
            itemBuilder: (_, index) => TaskItem(
              task: widget.tasksList[index],
            ),
          ),
        )
      ],
    );
  }

  EasyInfiniteDateTimeLine buildCalender() {
    return EasyInfiniteDateTimeLine(
      timeLineProps: EasyTimeLineProps(vPadding: 16.0.r),
      showTimelineHeader: false,
      firstDate: DateTime.now().subtract(
        const Duration(
          days: 365,
        ),
      ),
      focusDate: calenderSelectedDate,
      lastDate: DateTime.now().add(
        const Duration(days: 365),
      ),
      itemBuilder: (context, date, isSelected, onTap) => InkWell(
        onTap: () {
          calenderSelectedDate = date;
          getTasksFromFireStore();
          setState(() {});
        },
        child: Card(
          elevation: 8.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              12.0.r,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                date.weekDayFormatter,
                style: isSelected
                    ? LightAppStyle.selectedCalenderDate
                    : LightAppStyle.unSelectedCalenderDate,
              ),
              12.verticalSpace,
              Text(
                date.day.toString(),
                style: isSelected
                    ? LightAppStyle.selectedCalenderDate
                    : LightAppStyle.unSelectedCalenderDate,
              )
            ],
          ),
        ),
      ),
    );
  }

  void getTasksFromFireStore() async {
    CollectionReference todoCollection =
        FirebaseFirestore.instance.collection(TaskDataModel.collectionName);
    QuerySnapshot collectionSnapShot = await todoCollection.get();
    List<QueryDocumentSnapshot> documentSnapShot = collectionSnapShot.docs;
    widget.tasksList = documentSnapShot.map((docSnapShot) {
      Map<String, dynamic> json = docSnapShot.data() as Map<String, dynamic>;
      TaskDataModel task = TaskDataModel.fromFireStore(json);
      return task;
    }).toList();
    widget.tasksList = widget.tasksList
        .where((task) =>
            task.dateTime.day == calenderSelectedDate.day &&
            task.dateTime.month == calenderSelectedDate.month &&
            task.dateTime.year == calenderSelectedDate.year)
        .toList();
    setState(() {});
  }
}
