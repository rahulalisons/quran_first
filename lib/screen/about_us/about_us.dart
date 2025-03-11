import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/values/colors.dart';
import '../../core/values/strings.dart';
import '../common_widgets/custom_appbar.dart';
import '../common_widgets/custom_textstyle.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: PreferredSize(
          preferredSize: Size(ScreenUtil().screenWidth, 50),
          child: CustomAppbar(
            title: 'About Us',
            actions: [],
          )),
      body: SizedBox(
        width: ScreenUtil().screenWidth,
        height: ScreenUtil().screenHeight,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                
                constraints: BoxConstraints(
                    maxHeight: 210.h, minWidth: ScreenUtil().screenWidth),
                decoration: BoxDecoration(
                  color: Color(0xFFE9F3EC),
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: EdgeInsets.all(16.w),
                child: RichText(
                  text: TextSpan(
                    style: CustomFontStyle().common(
                        fontWeight: FontWeight.w400,
                        fontSize: 15.sp,
                        height: 1.5.h,
                        color: AppColors.textBlack),
                    children: [
                      TextSpan(
                        text: '"Quran First"',
                        style: CustomFontStyle().common(
                            fontWeight: FontWeight.w600,
                            fontSize: 15.sp,
                            color: AppColors.textBlack),
                      ),
                      TextSpan(
                        text: ' is developed and sponsored by the team of ',
                      ),
                      TextSpan(
                          text: 'Alisons Infomatics Pvt. Ltd.',
                          style: CustomFontStyle().common(
                              fontWeight: FontWeight.w600,
                              fontSize: 15.sp,
                              color: AppColors.textBlack)),
                      TextSpan(
                        text:
                            ' This is our gift to dear Muslim brothers and sisters. Alisons Infomatics Pvt. Ltd, is a leading IT solution provider based in Kannur, Kerala, India with global presence.',
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                width: ScreenUtil().screenWidth,
                decoration: BoxDecoration(
                  color: AppColors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: EdgeInsets.all(16.w),
                child: Column(
                  children: [
                    Text(
                      'Developed by',
                      style: CustomFontStyle().common(
                          fontWeight: FontWeight.w600,
                          fontSize: 20.sp,
                          color: AppColors.orange),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Image.asset(
                      ImageStrings.alisonLogo,
                      width: 100.w,
                      height: 100.w,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      'Alisons Infomatics (P) Ltd.',
                      style: CustomFontStyle().common(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp,
                          color: AppColors.textBlack.withOpacity(0.7)),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      'www.alisonsgroup.com',
                      style: CustomFontStyle().common(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp,
                          color: AppColors.textBlack.withOpacity(0.7)),
                    ),
                  ],
                ),
              ),
              Spacer(),
              SizedBox(
                height: 30,
                width: ScreenUtil().screenWidth,
                child: FittedBox(
                  child: Text(
                    '2025, Alisons Infomatics (P) Itd. All right reserved',
                    style: CustomFontStyle().common(
                        fontWeight: FontWeight.w400,
                        fontSize: 15.sp,
                        color: AppColors.textBlack.withOpacity(0.7)),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
