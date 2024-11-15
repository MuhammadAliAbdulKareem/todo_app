import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/utils/app_styles.dart';
import 'package:todo_app/core/utils/colors_manager.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  _SettingsTabState createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  String selectedLanguage = 'English';
  String selectedTheme = 'Light';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(38.0.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Language',
            style: LightAppStyle.dropdownMenuLabel,
          ),
          17.verticalSpace,
          buildDropdownButtonFormField(
              items: MenuItemsModel(
                item1: 'English',
                item2: 'العربية',
              ),
              selected: selectedLanguage),
          19.verticalSpace,
          Text(
            'Mode',
            style: LightAppStyle.dropdownMenuLabel,
          ),
          17.verticalSpace,
          buildDropdownButtonFormField(
            items: MenuItemsModel(
              item1: 'Light',
              item2: 'Dark',
            ),
            selected: selectedTheme,
          ),
        ],
      ),
    );
  }

  DropdownButtonFormField<String> buildDropdownButtonFormField({
    required MenuItemsModel items,
    required String selected,
  }) {
    return DropdownButtonFormField<String>(
      value: selected,
      items: [
        DropdownMenuItem(
          value: items.item1,
          child: Text(items.item1),
        ),
        DropdownMenuItem(
          value: items.item2,
          child: Text(items.item2),
        ),
      ],
      onChanged: (newSelectedItem) {
        setState(() {
          selected = newSelectedItem ?? selected;
        });
      },
      decoration: InputDecoration(
        fillColor: ColorsManager.white,
        filled: true,
        contentPadding:
            EdgeInsets.symmetric(vertical: 8.0.r, horizontal: 16.0.r),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0.r),
          borderSide: BorderSide(color: ColorsManager.blue, width: 1.5.r),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0.r),
          borderSide: BorderSide(color: ColorsManager.blue, width: 1.5.r),
        ),
      ),
      icon: const Icon(Icons.arrow_drop_down, color: ColorsManager.blue),
      style: LightAppStyle.dropdownMenuHint,
      dropdownColor: ColorsManager.white,
    );
  }
}

class MenuItemsModel {
  final String item1;
  final String item2;

  MenuItemsModel({required this.item1, required this.item2});
}
