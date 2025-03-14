import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/values/colors.dart';
import '../../../core/values/strings.dart';

class SocialButton extends StatelessWidget {
  final void Function()? onTap;
  final String? image;
  const SocialButton({super.key, this.onTap, this.image});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.lightGray,
            borderRadius: BorderRadius.circular(50)),
        width: 60.w,
        height: 60.w,
        child: Center(
          child: Image.asset(
           image?? ImageStrings.instagram,
            width: 20.w,
            height: 20.w,
          ),
        ),
      ),
    );
  }
}
