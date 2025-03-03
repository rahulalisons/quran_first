import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/values/colors.dart';
import 'custom_textstyle.dart';

class CustomAppbar extends StatelessWidget {
  final String? title;
  const CustomAppbar({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      surfaceTintColor: AppColors.white,
      centerTitle: false,
      // titleSpacing: 16,
      title: Text(
        title ?? 'The Quran',
        style: CustomFontStyle().common(
            fontWeight: FontWeight.w600,
            fontSize: 18.sp,
            color: AppColors.black),
      ),
      actions: [
        CircleAvatar(
          backgroundColor: AppColors.secondaryGreen,
          child: Center(
            child: Icon(
              Icons.bookmark_border,
              color: AppColors.white,
            ),
          ),
        ),
        SizedBox(
          width: 16,
        ),
      ],
    );
  }
}
