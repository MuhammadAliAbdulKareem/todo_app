import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/core/utils/colors_manager.dart';

class LightAppStyle {
  static TextStyle appBar = GoogleFonts.poppins(
    color: ColorsManager.white,
    fontSize: 22.sp,
    fontWeight: FontWeight.w700,
  );
  static TextStyle dropdownMenuLabel = GoogleFonts.poppins(
    color: ColorsManager.blackAccent2,
    fontSize: 18.sp,
    fontWeight: FontWeight.w700,
  );
  static TextStyle dropdownMenuHint = GoogleFonts.poppins(
    color: ColorsManager.blue,
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
  );
  static TextStyle bottomSheetLabel = GoogleFonts.poppins(
    fontSize: 22.sp,
    fontWeight: FontWeight.w700,
    color: ColorsManager.blackAccent,
  );
  static TextStyle textFieldHint = GoogleFonts.inter(
    fontSize: 17.sp,
    fontWeight: FontWeight.w500,
    color: ColorsManager.grey,
  );
  static TextStyle selectedDate = GoogleFonts.inter(
    color: ColorsManager.blackAccent,
    fontSize: 19.sp,
    fontWeight: FontWeight.w600,
  );
  static TextStyle buttonLabel = GoogleFonts.inter(
    color: ColorsManager.white,
    fontSize: 21.sp,
    fontWeight: FontWeight.w500,
  );
  static TextStyle taskTime = GoogleFonts.roboto(
    fontSize: 13.sp,
    fontWeight: FontWeight.w500,
    color: ColorsManager.blackAccent3,
  );
  static TextStyle taskTitle = GoogleFonts.poppins(
    color: ColorsManager.blue,
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
  );

  static TextStyle selectedCalenderDate = GoogleFonts.roboto(
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
    color: ColorsManager.blue,
  );
  static TextStyle unSelectedCalenderDate = GoogleFonts.roboto(
    fontSize: 18.sp,
    fontWeight: FontWeight.w700,
    color: ColorsManager.blackAccent3,
  );
}
