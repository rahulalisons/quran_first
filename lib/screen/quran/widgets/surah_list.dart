import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_first/screen/quran/widgets/surah_tile.dart';

class SurahList extends StatelessWidget {
  const SurahList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: EdgeInsets.symmetric(vertical: 15.h),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return SurahTile(
            count: '${index + 1}',
          );
        },
        separatorBuilder: (context, index) => SizedBox(
          height: 13.h,
        ),
        itemCount: 100);
  }
}
