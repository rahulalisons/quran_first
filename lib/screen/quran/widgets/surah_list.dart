import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:quran_first/controller/quran_provider.dart';
import 'package:quran_first/screen/quran/widgets/surah_tile.dart';

import '../../../db_helper/db_helper.dart';

class SurahList extends StatelessWidget {
  const SurahList({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<QuranProvider>(builder: (context, data, _) {
      return ListView.separated(
          padding: EdgeInsets.symmetric(vertical: 15.h),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            List<Map<String, dynamic>> sortedList =
                List.from(data.arData ?? []);
            sortedList.sort((a, b) =>
                (a['surath_no'] as num).compareTo(b['surath_no'] as num));
            return SurahTile(
              arSurah: sortedList[index],
              enSurah: data.enData![index],
              verses: data.count![index],
            );
          },
          separatorBuilder: (context, index) => SizedBox(
                height: 13.h,
              ),
          itemCount: data.arData?.length ?? 0);
    });
  }
}
