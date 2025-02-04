import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/utils/extensions/date_format.dart';
import 'package:todo_app/database_manager/model/todo_data_model.dart';
import 'package:todo_app/presentation/screens/home/tabs/tasks/tasks_tab.dart';
import 'package:todo_app/provider/tasks_provider.dart';

import '../utils/app_styles.dart';
import '../utils/colors_manager.dart';

class CustomBottomSheet extends StatefulWidget {
  CustomBottomSheet({
    super.key,
    // required this.context,
    required this.cardTitle,
    required this.buttonLabel,
    required this.cardHeight,
    required this.selectedDate,
    this.task,
    this.isBottomSheet = false,
  });
  TaskDataModel? task;
  // BuildContext context;
  DateTime selectedDate;
  final String cardTitle;
  final String buttonLabel;
  final double cardHeight;
  bool isBottomSheet;
  TextEditingController descriptionController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  GlobalKey<TasksTabState> taskTabState = GlobalKey();
  bool isLoading = false;
  @override
  State<CustomBottomSheet> createState() => CustomBottomSheetState();
}

class CustomBottomSheetState extends State<CustomBottomSheet> {
  @override
  Widget build(
    BuildContext context,
  ) {
    TasksProvider tasksProvider = Provider.of<TasksProvider>(context);

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
              maxLines: 5,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    12.0.r,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      12.0.r,
                    ),
                    borderSide: const BorderSide(
                      color: ColorsManager.blue,
                    )),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      12.0.r,
                    ),
                    borderSide: const BorderSide(color: Colors.red)),
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
            widget.isBottomSheet ? const Spacer() : 50.verticalSpace,
            ElevatedButton(
              onPressed: widget.isLoading
                  ? null
                  : () {
                      if (widget.isBottomSheet) {
                        if (widget.formKey.currentState?.validate() == false) {
                          return;
                        }
                        setState(() {
                          widget.isLoading = true;
                        });

                        tasksProvider.addTaskToFireStore(
                          TaskDataModel(
                              dateTime: DateTime(
                                widget.selectedDate.year,
                                widget.selectedDate.month,
                                widget.selectedDate.day,
                                // widget.selectedDate.hour,
                                // widget.selectedDate.minute,
                              ),
                              title: widget.titleController.text.trim(),
                              description:
                                  widget.descriptionController.text.trim()),
                        );
                        Navigator.pop(context);
                      } else {
                        if (widget.formKey.currentState?.validate() == false) {
                          return;
                        }
                        setState(() {
                          widget.isLoading = true;
                        });

                        widget.task!.dateTime = DateTime(
                          widget.selectedDate.year,
                          widget.selectedDate.month,
                          widget.selectedDate.day,
                          // widget.selectedDate.hour,
                          // widget.selectedDate.minute,
                        );

                        widget.task!.title = widget.titleController.text.trim();
                        widget.task!.description =
                            widget.descriptionController.text.trim();
                        tasksProvider.updateTaskFromFireStore(widget.task);

                        Navigator.pop(context);
                      }
                      setState(() {
                        widget.isLoading = false;
                      });
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
              child: widget.isLoading
                  ? Text(
                      'Is Loading....',
                      style: LightAppStyle.buttonLabel,
                    )
                  : Text(
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
    // setState(() {});
  }

  // void addTaskToFireStore() {
  //   if (widget.formKey.currentState?.validate() == false) return;

  //   CollectionReference todoCollection =
  //       FirebaseFirestore.instance.collection(TaskDataModel.collectionName);
  //   DocumentReference documentReference = todoCollection.doc();
  //   TaskDataModel taskDataModel = TaskDataModel(
  //       id: documentReference.id,
  //       title: widget.titleController.text,
  //       description: widget.descriptionController.text,
  //       dateTime: widget.selectedDate,
  //       status: false);
  //   documentReference
  //       .set(
  //         taskDataModel.toFireStore(),
  //       )
  //       .then((_) {
  //         if (context.mounted) {
  //           Navigator.pop(
  //             context,
  //           );
  //         }
  //       })
  //       .onError((error, stackTrace) {})
  //       .timeout(
  //         const Duration(
  //           seconds: 4,
  //         ),
  //         onTimeout: () {
  //           if (context.mounted) {
  //             Navigator.pop(
  //               context,
  //             );
  //           }
  //         },
  //       );
  // }

  // void updateTaskFromFireStore(TaskDataModel? task) async {
  //   CollectionReference todoCollection =
  //       FirebaseFirestore.instance.collection(TaskDataModel.collectionName);
  //   DocumentReference todoDoc = todoCollection.doc(task!.id);
  //   task.dateTime = widget.selectedDate;
  //   task.title = widget.titleController.text;
  //   task.description = widget.descriptionController.text;
  //   await todoDoc
  //       .update(task.toFireStore())
  //       .then((_) {
  //         if (context.mounted) {
  //           Navigator.pop(context, true);
  //         }
  //       })
  //       .onError((error, stackTrace) {})
  //       .timeout(const Duration(seconds: 5), onTimeout: () {
  //         if (context.mounted) {
  //           Navigator.pop(context, true);
  //         }
  //       });
  // }
}
