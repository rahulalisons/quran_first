import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/values/colors.dart';
import '../../../core/values/strings.dart';
import '../../common_widgets/custom_textstyle.dart';

class SettingsTile extends StatelessWidget {
  final String? title;
  final String? image;
  final Widget? action;
  final void Function()? onTap;
  const SettingsTile(
      {super.key, this.title, this.image, this.action, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        width: ScreenUtil().screenWidth,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.lightGray),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        child: Row(
          children: [
            Image.asset(
              image ?? ImageStrings.aboutUs,
              width: 24.w,
              height: 24.w,
            ),
            SizedBox(
              width: 15.w,
            ),
            Expanded(
              child: Text(
                title ?? 'About Us',
                style: CustomFontStyle().common(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                    color: AppColors.black),
              ),
            ),
            action ??
                CircleAvatar(
                  backgroundColor: AppColors.white,
                  radius: 18,
                  child: Center(
                    child: Icon(Icons.chevron_right),
                  ),
                )
          ],
        ),
      ),
    );
  }
}
