import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_first/core/values/strings.dart';

import '../../core/values/colors.dart';
import '../common_widgets/custom_textstyle.dart';

class PrayerTime extends StatelessWidget {
  const PrayerTime({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: ScreenUtil().screenHeight,
        width: ScreenUtil().screenWidth,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primary, const Color(0xFF07170D)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 38.w),
                child: Image.asset(
                  ImageStrings.prayerComingSoon,
                  height: 130.h,
                  width: 152.h,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                textAlign: TextAlign.center,
                'COMING SOON : \nPrayer Times Feature!',
                style: CustomFontStyle().common(
                    fontWeight: FontWeight.w600,
                    fontSize: 24.sp,
                    color: AppColors.white),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                textAlign: TextAlign.center,
                'Stay tuned for accurate prayer timings based on your location. Making it easier for you to stay connected to your prayers!',
                style: CustomFontStyle().common(
                    fontWeight: FontWeight.w400,
                    fontSize: 16.sp,
                    color: AppColors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
