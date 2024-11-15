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
}
