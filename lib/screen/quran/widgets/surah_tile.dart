import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:quran_first/controller/quran_provider.dart';

import '../../../core/values/colors.dart';
import '../../../core/values/strings.dart';
import '../../common_widgets/custom_textstyle.dart';
import '../surah_details_screen.dart';

class SurahTile extends StatelessWidget {
  final Map<String, dynamic>? enSurah;
  final Map<String, dynamic>? arSurah;
  final bool? isJuz;
  final Map<String, dynamic>? verses;
  const SurahTile(
      {super.key, this.isJuz = false, this.enSurah, this.arSurah, this.verses});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(enSurah?['surath_no']);
        context.read<QuranProvider>().ayathBySurath(enSurah?['surath_no']);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SurahDetailsScreen(
                verses: verses,
                enSurah: enSurah,
                arSurah: arSurah,
              ),
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
                  enSurah?['surath_no'].toString() ?? "",
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
                    enSurah?['surath_name'] ?? '',
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
                          '${verses!['ayah_count']} Verses',
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
                    arSurah!['surath_name'],
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
