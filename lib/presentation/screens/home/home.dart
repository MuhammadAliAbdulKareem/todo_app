import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/utils/app_styles.dart';
import 'package:todo_app/core/widgets/add_task_bottom_sheet.dart';
import 'package:todo_app/presentation/screens/home/tabs/settings/settings_tab.dart';
import 'package:todo_app/presentation/screens/home/tabs/tasks/tasks_tab.dart';
import 'package:todo_app/provider/tasks_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> tabs = [
    const TasksTab(),
    const SettingsTab(),
  ];
  int currentTab = 0;

  @override
  Widget build(BuildContext context) {
    TasksProvider tasksProvider = Provider.of<TasksProvider>(context);
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 60.0.w,
        title: Text(
          "ToDo List",
          style: LightAppStyle.appBar,
        ),
      ),
      body: tabs[currentTab],
      floatingActionButton: buildFAB(tasksProvider),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: buildBNV(),
    );
  }

  Widget buildBNV() {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(
          16.0.r,
        ),
        topRight: Radius.circular(
          16.0.r,
        ),
      ),
      child: BottomAppBar(
        notchMargin: 12.0.r,
        child: BottomNavigationBar(
          currentIndex: currentTab,
          onTap: (index) {
            currentTab = index;
            setState(() {});
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.list_sharp),
              label: "Tasks",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined),
              label: "Settings",
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFAB(TasksProvider tasksProvider) {
    return FloatingActionButton(
      onPressed: () async {
        await AddTaskBottomSheet.show(context);
        // tasksTabState.currentState?.getTasksFromFireStore();
        tasksProvider.getTasksByDateFromFireStore();
      },
      child: const Icon(
        Icons.add,
      ),
    );
  }
}
