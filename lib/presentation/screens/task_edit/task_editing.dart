import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/utils/colors_manager.dart';
import 'package:todo_app/core/widgets/custom_bottom_sheet.dart';
import 'package:todo_app/database_manager/model/todo_data_model.dart';

import '../../../core/utils/app_styles.dart';

class TaskEditing extends StatefulWidget {
  TaskEditing({super.key, required this.task});

  DateTime selectedDate = DateTime.now();
  TaskDataModel task;
  @override
  State<TaskEditing> createState() => _TaskEditingState();
}

class _TaskEditingState extends State<TaskEditing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ToDo List",
          style: LightAppStyle.appBar,
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: 70.0.h,
            color: ColorsManager.blue,
          ),
          Padding(
            padding: REdgeInsets.symmetric(horizontal: 33.0, vertical: 24.0),
            child: SingleChildScrollView(
              child: CustomBottomSheet(
                cardTitle: "Edit Task",
                buttonLabel: "Save Changes",
                cardHeight: 620.h,
                selectedDate: widget.selectedDate,
                task: widget.task,
              ),
            ),
          )
        ],
      ),
    );
  }
}
