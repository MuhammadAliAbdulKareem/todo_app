import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/utils/extensions/date_format.dart';
import 'package:todo_app/database_manager/model/todo_data_model.dart';

import '../utils/app_styles.dart';
import '../utils/colors_manager.dart';

class CustomTaskCard extends StatefulWidget {
  CustomTaskCard({
    super.key,
    required BuildContext context,
    required this.cardTitle,
    required this.buttonLabel,
    required this.cardHeight,
    required this.selectedDate,
    this.isBottomSheet = false,
  });
  DateTime selectedDate;
  final String cardTitle;
  final String buttonLabel;
  final double cardHeight;
  bool isBottomSheet;
  TextEditingController descriptionController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  State<CustomTaskCard> createState() => _CustomTaskCardState();
}

class _CustomTaskCardState extends State<CustomTaskCard> {
  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      margin: MediaQuery.of(context).viewInsets,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        borderRadius: widget.isBottomSheet
            ? BorderRadius.only(
                topLeft: Radius.circular(
                  16.0.r,
                ),
                topRight: Radius.circular(
                  16.0.r,
                ),
              )
            : BorderRadius.circular(
                16.0.r,
              ),
        color: ColorsManager.white,
      ),
      height: widget.cardHeight,
      child: Form(
        key: widget.formKey,
        child: Column(
          children: [
            Text(
              widget.cardTitle,
              style: LightAppStyle.bottomSheetLabel,
            ),
            16.verticalSpace,
            TextFormField(
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Plz, Enter The Task Title';
                }
                return null;
              },
              controller: widget.titleController,
              decoration: InputDecoration(
                hintText: "Enter Your Task Title",
                hintStyle: LightAppStyle.textFieldHint,
              ),
            ),
            16.verticalSpace,
            TextFormField(
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Plz, Enter The Task Descripion';
                }
                if (value.length < 4) {
                  return 'Plz, Task Description Must be at least 4 chars';
                }
                return null;
              },
              controller: widget.descriptionController,
              decoration: InputDecoration(
                hintText: "Enter Your Task Description",
                hintStyle: LightAppStyle.textFieldHint,
              ),
            ),
            16.verticalSpace,
            InkWell(
              onTap: () {
                showTaskDatePicker(context);
              },
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Select Date',
                  style: LightAppStyle.selectedDate,
                ),
              ),
            ),
            16.verticalSpace,
            Text(
              widget.selectedDate.dateFormatter,
              style: LightAppStyle.textFieldHint,
            ),
            widget.isBottomSheet ? const Spacer() : 160.verticalSpace,
            ElevatedButton(
              onPressed: () {
                addTaskToFireStore();
              },
              style: ElevatedButton.styleFrom(
                fixedSize: widget.isBottomSheet
                    ? Size(MediaQuery.of(context).size.width, 30.h)
                    : Size(MediaQuery.of(context).size.width * 0.7, 60.h),
                backgroundColor: ColorsManager.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    widget.isBottomSheet ? 20.0.r : 32.0.r,
                  ),
                ),
              ),
              child: Text(
                widget.buttonLabel,
                style: LightAppStyle.buttonLabel,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> showTaskDatePicker(BuildContext context) async {
    widget.selectedDate = await showDatePicker(
          context: context,
          firstDate: DateTime.now(),
          initialDate: DateTime.now(),
          lastDate: DateTime.now().add(
            const Duration(
              days: 365,
            ),
          ),
        ) ??
        widget.selectedDate;
    setState(() {});
  }

  void addTaskToFireStore() {
    if (widget.formKey.currentState?.validate() == false) return;

    CollectionReference todoCollection =
        FirebaseFirestore.instance.collection(TaskDataModel.collectionName);
    DocumentReference documentReference = todoCollection.doc();
    TaskDataModel taskDataModel = TaskDataModel(
        id: documentReference.id,
        title: widget.titleController.text,
        description: widget.descriptionController.text,
        dateTime: widget.selectedDate,
        status: false);
    documentReference
        .set(
          taskDataModel.toFireStore(),
        )
        .then((_) {
          if (context.mounted) {
            Navigator.pop(context);
          }
        })
        .onError((error, stackTrace) {})
        .timeout(
          const Duration(
            seconds: 4,
          ),
          onTimeout: () {
            if (context.mounted) {
              Navigator.pop(context);
            }
          },
        );
  }
}
