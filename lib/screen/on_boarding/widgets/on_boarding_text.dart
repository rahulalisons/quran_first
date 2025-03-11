import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/values/colors.dart';
import '../../../core/values/strings.dart';
import '../../common_widgets/custom_textstyle.dart';

class OnBoardingText extends StatelessWidget {
  final String? image;
  final String? title;
  final String? subtitle;
  final double? height;
  final double? titleHeight;

  const OnBoardingText({super.key, this.image, this.title, this.subtitle, this.height, this.titleHeight});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            image ?? ImageStrings.onboarding1,
            height:height?? 260.h,
          ),
          SizedBox(
            height:titleHeight?? 25.h,
          ),
          Text(
            title ?? 'Discover Divine Wisdom',
            style: CustomFontStyle().common(
                color: AppColors.white,
                fontWeight: FontWeight.w700,
                fontSize: 20.sp,
              ),

          ),
          SizedBox(height: 10.h,),
          Text(
            subtitle ??
                'Immerse yourself in the timeless wisdom of the Quran. Read, reflect, and grow spiritually with ease.',
            textAlign: TextAlign.center,
            style: CustomFontStyle().common(
              color: AppColors.white.withOpacity(0.6),
              fontWeight: FontWeight.w400,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }
}
