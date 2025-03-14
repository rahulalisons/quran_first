import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:quran_first/controller/db_provider.dart';

import '../../../core/values/colors.dart';
import '../../common_widgets/custom_textstyle.dart';

class ReandomAyath extends StatelessWidget {
  const ReandomAyath({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DbProvider>(builder: (context, random, _) {
      return Container(
        height: 180.h,
        width: 330.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              image: AssetImage(
                'assets/app/images/home_screen_surah.png',
              ),
              fit: BoxFit.fill,
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 250.w,
              child: Column(
                children: [
                  Text(
                    '${random.randomAyath?.first['ar_ayath_text']}',
                    textAlign: TextAlign.center,
                    style: CustomFontStyle().common(
                      color: AppColors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  // Html(
                  //   data: random.randomAyath?.first['en_ayath_text'],
                  //   shrinkWrap: true,
                  //   style: {
                  //     "body": Style(
                  //         fontFamily: 'Manrope',
                  //         color: AppColors.white,
                  //         fontSize: FontSize(14.sp),
                  //         textAlign: TextAlign.start),
                  //   },
                  // ),
                  Text(
                    '${random.randomAyath?.first['en_ayath_text']}',
                    textAlign: TextAlign.center,
                    style: CustomFontStyle().common(
                      color: AppColors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    'Surah ${random.randomAyath?.first['surah_name']} ${random.randomAyath?.first['surah_no']} - ${random.randomAyath?.first['ayath_no']}',
                    style: CustomFontStyle().common(
                      color: AppColors.white,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
