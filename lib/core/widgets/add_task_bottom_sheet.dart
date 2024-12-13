import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_task.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();

  static Future show(context) => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => const AddTaskBottomSheet(),
      );
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return CustomTaskCard(
      context: context,
      selectedDate: selectedDate,
      cardTitle: 'Add New Task',
      buttonLabel: 'Add Task',
      cardHeight: 425.h,
      isBottomSheet: true,
    );
  }
}
