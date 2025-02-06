import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_styles.dart';
import '../utils/colors_manager.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.validator,
    required this.controller,
    this.maxLines = 1,
  });

  final String? Function(String?)? validator;
  final String hintText;
  final TextEditingController controller;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      maxLines: maxLines,
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
          borderSide: const BorderSide(color: Colors.red),
        ),
        hintText: hintText,
        hintStyle: LightAppStyle.textFieldHint,
      ),
    );
  }
}
