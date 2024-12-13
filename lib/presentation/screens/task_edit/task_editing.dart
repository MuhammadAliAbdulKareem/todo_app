import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/utils/colors_manager.dart';
import 'package:todo_app/core/widgets/custom_task.dart';

import '../../../core/utils/app_styles.dart';

class TaskEditing extends StatelessWidget {
  const TaskEditing({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime selectedDate = DateTime.now();
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
            child: CustomTaskCard(
              context: context,
              cardTitle: "Edit Task",
              buttonLabel: "Save Changes",
              cardHeight: 620.h,
              selectedDate: selectedDate,
            ),
          )
        ],
      ),
    );
  }
}
