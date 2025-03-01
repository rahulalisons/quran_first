import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/values/colors.dart';
import '../../../core/values/strings.dart';
import '../../common_widgets/custom_textstyle.dart';
import '../surah_details_screen.dart';

class SurahTile extends StatelessWidget {
  final String? count;
  final bool? isJuz;
  const SurahTile({super.key, this.count, this.isJuz = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SurahDetailsScreen(),
            ));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 13.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.lightGreen),
        child: Row(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  ImageStrings.juzCount,
                  height: 40.w,
                  width: 40.w,
                  fit: BoxFit.cover, // optional
                ),
                Text(
                  count ?? '',
                  style: CustomFontStyle().common(
                    color: AppColors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 18.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Al-Fatihah',
                    maxLines: 1,
                    style: CustomFontStyle().common(
                      color: AppColors.black,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  isJuz == true
                      ? SizedBox()
                      : Text(
                          '7 Verses',
                          style: CustomFontStyle().common(
                            color: AppColors.textBlack,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                ],
              ),
            ),
            isJuz == true
                ? Text(
                    'Verse 1 - 7',
                    style: CustomFontStyle().common(
                      color: AppColors.textBlack.withOpacity(0.6),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                : Text(
                    'الافتتاح',
                    style: CustomFontStyle().common(
                      color: AppColors.black,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
