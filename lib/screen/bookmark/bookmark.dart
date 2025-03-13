import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:quran_first/controller/db_provider.dart';
import 'package:quran_first/screen/bookmark/widget/bookmark_tile.dart';

import '../../core/values/colors.dart';
import '../common_widgets/custom_textstyle.dart';
import '../quran/widgets/ayat_tile.dart';

class Bookmark extends StatefulWidget {
  const Bookmark({super.key});

  @override
  State<Bookmark> createState() => _BookmarkState();
}

class _BookmarkState extends State<Bookmark> {
  @override
  void initState() {
    super.initState();
    Provider.of<DbProvider>(context, listen: false).getBookmarkedAyat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.transparent,
        title: Text(
          'Bookmarks',
          style: CustomFontStyle().common(
            fontWeight: FontWeight.w600,
            fontSize: 18.sp,
            color: AppColors.textBlack,
          ),
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: context.read<DbProvider>().bookmarkedList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No bookmarked ayaths found."));
          }

          Map<int, List<Map<String, dynamic>>> groupedAyaths = {};
          for (var ayath in snapshot.data!) {
            groupedAyaths.putIfAbsent(ayath['surath_no'], () => []).add(ayath);
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) {
              int surathNo = groupedAyaths.keys.elementAt(index);
              List<Map<String, dynamic>> ayathList = groupedAyaths[surathNo]!;

              return Container(
                decoration: BoxDecoration(
                  color: AppColors.appBarColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ExpansionTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  collapsedShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  tilePadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ayathList.first['surath_name'],
                        style: CustomFontStyle().common(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                          color: AppColors.textBlack,
                        ),
                      ),
                      Text(
                        '${ayathList.first['bookmark_count']} Bookmarks',
                        style: CustomFontStyle().common(
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                          color: AppColors.textBlack,
                        ),
                      ),
                    ],
                  ),
                  children: [
                    Container(
                      width: ScreenUtil().screenWidth,
                      color: Colors.white,
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 10),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> ayath = ayathList[index];

                          return BookmarkTile(ayath: ayath,);
                        },
                        itemCount: groupedAyaths[surathNo]!.length,
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemCount: groupedAyaths.keys.length,
          );
        },
      ),
    );
  }

  void _removeBookmark(Map<String, dynamic> ayath) {
    context
        .read<DbProvider>()
        .removeBookMark(
          ayathNo: ayath['ayath_no'],
          surahNo: ayath['surath_no'],
        )
        .then((value) {
      if (value) {
        Provider.of<DbProvider>(context, listen: false).getBookmarkedAyat();
      }
    });
  }
}
