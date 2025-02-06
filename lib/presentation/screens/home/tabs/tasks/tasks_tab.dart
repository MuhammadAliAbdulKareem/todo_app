import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/utils/app_styles.dart';
import 'package:todo_app/core/utils/colors_manager.dart';
import 'package:todo_app/core/utils/extensions/date_format.dart';
import 'package:todo_app/presentation/screens/home/tabs/tasks/task_item/task_item_widget.dart';
import 'package:todo_app/provider/tasks_provider.dart';

class TasksTab extends StatefulWidget {
  const TasksTab({super.key});

  @override
  State<TasksTab> createState() => TasksTabState();
}

class TasksTabState extends State<TasksTab> {
  DateTime calenderSelectedDate = DateTime.now();
  @override
  @override
  Widget build(BuildContext context) {
    TasksProvider tasksProvider = Provider.of<TasksProvider>(context);
    return Column(
      children: [
        Stack(
          children: [
            Container(
              color: ColorsManager.blue,
              height: 70.0.h,
            ),
            buildCalender(tasksProvider),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: tasksProvider.allTasks.length,
            itemBuilder: (_, index) => TaskItem(
              task: tasksProvider.allTasks[index],
            ),
          ),
        )
      ],
    );
  }

  EasyInfiniteDateTimeLine buildCalender(TasksProvider tasksProvider) {
    return EasyInfiniteDateTimeLine(
      timeLineProps: EasyTimeLineProps(vPadding: 16.0.r),
      showTimelineHeader: false,
      firstDate: DateTime.now().subtract(
        const Duration(
          days: 365,
        ),
      ),
      focusDate: tasksProvider.selectedDate,
      lastDate: DateTime.now().add(
        const Duration(days: 365),
      ),
      itemBuilder: (context, date, isSelected, onTap) => InkWell(
        onTap: () {
          tasksProvider.changeSelectedDate(date);

          Fluttertoast.showToast(
            msg: '${tasksProvider.selectedDate}',
            backgroundColor: Colors.red,
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_LONG,
          );
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

  // void getTasksFromFireStore() async {
  //   CollectionReference todoCollection =
  //       FirebaseFirestore.instance.collection(TaskDataModel.collectionName);
  //   QuerySnapshot collectionSnapShot = await todoCollection.get();
  //   List<QueryDocumentSnapshot> documentSnapShot = collectionSnapShot.docs;
  //   widget.tasksList = documentSnapShot.map((docSnapShot) {
  //     Map<String, dynamic> json = docSnapShot.data() as Map<String, dynamic>;
  //     TaskDataModel task = TaskDataModel.fromFireStore(json);
  //     return task;
  //   }).toList();
  //   widget.tasksList = widget.tasksList
  //       .where((task) =>
  //           task.dateTime.day == calenderSelectedDate.day &&
  //           task.dateTime.month == calenderSelectedDate.month &&
  //           task.dateTime.year == calenderSelectedDate.year)
  //       .toList();
  //   setState(() {});
  // }
}
