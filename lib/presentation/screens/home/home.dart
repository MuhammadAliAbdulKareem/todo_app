import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/utils/app_styles.dart';
import 'package:todo_app/core/widgets/add_task_bottom_sheet.dart';
import 'package:todo_app/presentation/screens/home/tabs/settings/settings_tab.dart';
import 'package:todo_app/presentation/screens/home/tabs/tasks/tasks_tab.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> tabs = [];
  int currentTab = 0;
  GlobalKey<TasksTabState> tasksTabState = GlobalKey();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabs = [
      TasksTab(
        key: tasksTabState,
      ),
      const SettingsTab(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 60.0.w,
        title: Text(
          "ToDo List",
          style: LightAppStyle.appBar,
        ),
      ),
      body: tabs[currentTab],
      floatingActionButton: buildFAB(),
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

  Widget buildFAB() {
    return FloatingActionButton(
      onPressed: () async {
        await AddTaskBottomSheet.show(context);
        tasksTabState.currentState?.getTasksFromFireStore();
      },
      child: const Icon(
        Icons.add,
      ),
    );
  }
}
