import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/utils/colors_manager.dart';
import 'package:todo_app/core/utils/extensions/date_format.dart';
import 'package:todo_app/core/utils/route_manager.dart';
import 'package:todo_app/database_manager/model/todo_data_model.dart';
import 'package:todo_app/provider/tasks_provider.dart';

import '../../../../../../core/utils/app_styles.dart';
import '../../../../../../core/utils/assets_manager.dart';

class TaskItem extends StatefulWidget {
  final TaskDataModel task;

  const TaskItem({
    super.key,
    required this.task,
  });

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    TasksProvider tasksProvider = Provider.of<TasksProvider>(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.0.w, vertical: 16.0.h),
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.circular(
          16.0.r,
        ),
      ),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: 0.3,
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (context) async {
                await tasksProvider.deleteTaskFromFireStore(widget.task);
              },
              backgroundColor: ColorsManager.red,
              foregroundColor: ColorsManager.white,
              icon: Icons.delete,
              label: 'Delete',
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                  16.0.r,
                ),
                bottomLeft: Radius.circular(
                  16.0.r,
                ),
              ),
            ),
          ],
        ),
        endActionPane: ActionPane(
            extentRatio: 0.3,
            motion: const DrawerMotion(),
            children: [
              SlidableAction(
                onPressed: (context) {
                  Navigator.pushNamed(
                    context,
                    RouteManager.taskEditing,
                    arguments: widget.task,
                  );
                  // ).then((value) {
                  //   if (value == true) {
                  //     tasksProvider.getTasksByDateFromFireStore();
                  //   }
                  // });
                },
                backgroundColor: ColorsManager.blue,
                foregroundColor: Colors.white,
                icon: Icons.edit,
                label: 'Edit',
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(
                    16.0.r,
                  ),
                  bottomRight: Radius.circular(
                    16.0.r,
                  ),
                ),
              ),
            ]),
        child: ListTile(
          leading: VerticalDivider(
            color:
                widget.task.status ? ColorsManager.green : ColorsManager.blue,
            thickness: 4.0.r,
          ),
          horizontalTitleGap: 0.0,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          title: Text(
            widget.task.title,
            style: widget.task.status
                ? LightAppStyle.taskTitle.copyWith(color: ColorsManager.green)
                : LightAppStyle.taskTitle,
          ),
          subtitle: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(
                Assets.assetsImagesDiscovery,
              ),
              // const SizedBox(width: 4),
              4.horizontalSpace,
              Text(
                widget.task.dateTime.hoursFormatter.toString(),
                style: LightAppStyle.taskTime,
              ),
            ],
          ),
          trailing: InkWell(
            onTap: () {
              widget.task.status = !widget.task.status;
              setState(() {});
            },
            child: widget.task.status
                ? Padding(
                    padding: REdgeInsets.only(right: 12.0),
                    child: Text(
                      'Done!',
                      style: GoogleFonts.poppins(
                        fontSize: 24.sp,
                        color: ColorsManager.green,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
                : Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                    width: 75.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: ColorsManager.blue,
                      borderRadius: BorderRadius.circular(10.0.r),
                    ),
                    child: SvgPicture.asset(
                      Assets.assetsImagesDone,
                      // width: 25.8.w,
                      // height: 19.24.h,
                      // width: 200,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  // void deleteTaskFromFireStore(TaskDataModel task) async {
  //   CollectionReference todoCollection =
  //       FirebaseFirestore.instance.collection(TaskDataModel.collectionName);
  //   DocumentReference todoDoc = todoCollection.doc(task.id);
  //   await todoDoc.delete();
  // }
}
