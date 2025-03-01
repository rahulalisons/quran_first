import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_first/screen/quran/widgets/surah_tile.dart';

import '../../../core/values/colors.dart';
import '../../common_widgets/custom_textstyle.dart';

class JuzList extends StatelessWidget {
  const JuzList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: EdgeInsets.symmetric(vertical: 15.h),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Juz ${index+1}',
                style: CustomFontStyle().common(
                  color: AppColors.textBlack,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              ListView.separated(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return SurahTile(
                      isJuz: true,
                      count: '${index + 1}',
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(
                        height: 10.h,
                      ),
                  itemCount: 2)
            ],
          );
        },
        separatorBuilder: (context, index) => SizedBox(
              height: 13.h,
            ),
        itemCount: 30);
  }
}
