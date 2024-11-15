import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/utils/app_styles.dart';
import 'package:todo_app/presentation/screens/home/tabs/settings/settings_tab.dart';
import 'package:todo_app/presentation/screens/home/tabs/tasks/tasks_tab.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> tabs = const [
    TasksTab(),
    SettingsTab(),
  ];

  int currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Padding(
          padding: EdgeInsets.only(
            top: 70.0.h,
            left: 52.0.w,
          ),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              "ToDo List",
              style: LightAppStyle.appBar,
            ),
          ),
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
      onPressed: () {},
      child: const Icon(
        Icons.add,
      ),
    );
  }
}
