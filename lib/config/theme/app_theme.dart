import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/utils/colors_manager.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    scaffoldBackgroundColor: ColorsManager.greenAccent,
    useMaterial3: false,
    appBarTheme: const AppBarTheme(
      backgroundColor: ColorsManager.blue,
      // toolbarHeight: 157.h,
      elevation: 0.0,
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      shape: CircularNotchedRectangle(),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.transparent,
      elevation: 0,
      selectedItemColor: ColorsManager.blue,
      unselectedItemColor: ColorsManager.grey,
      selectedIconTheme: IconThemeData(size: 36.0.r),
      unselectedIconTheme: IconThemeData(size: 32.0.r),
      showSelectedLabels: true,
      showUnselectedLabels: false,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      shape: StadiumBorder(
        side: BorderSide(
          color: ColorsManager.white,
          width: 4.0.r,
        ),
      ),
      iconSize: 32.r,
      foregroundColor: ColorsManager.white,
      backgroundColor: ColorsManager.blue,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: ColorsManager.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(
            16.0.r,
          ),
          topLeft: Radius.circular(16.0.r),
        ),
      ),
    ),
  );
  static ThemeData dark = ThemeData(
    useMaterial3: false,
  );
}
