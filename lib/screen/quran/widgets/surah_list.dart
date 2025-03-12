import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:quran_first/screen/quran/widgets/surah_tile.dart';

import '../../../controller/db_provider.dart';

class SurahList extends StatelessWidget {
  const SurahList({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: context.watch<DbProvider>().futureSurahList, // Listen for changes
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No data found'));
        }

        final surahList = snapshot.data!;
        return ListView.separated(
          padding: EdgeInsets.symmetric(vertical: 15.h),
          separatorBuilder: (context, index) => SizedBox(height: 13.h),
          itemCount: surahList.length,
          itemBuilder: (context, index) {
            final surah = surahList[index];
            return SurahTile(surah: surah);
          },
        );
      },
    );
  }
}
