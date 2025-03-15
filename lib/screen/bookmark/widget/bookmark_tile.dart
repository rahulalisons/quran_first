import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:quran_first/screen/quran/widgets/ayat_tile.dart';

import '../../../controller/db_provider.dart';
import '../../../core/values/colors.dart';
import '../../../core/values/strings.dart';
import '../../../models/bookmark_model.dart';
import '../../common_widgets/custom_textstyle.dart';
import '../../quran/surah_details_screen.dart';

class BookmarkTile extends StatelessWidget {
  final int? surahNo;
  final String? surahName;
  final Bookmark bookmarkAyath;
  const BookmarkTile(
      {super.key, required this.bookmarkAyath, this.surahNo, this.surahName});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SurahDetailsScreen(
                surathId: surahNo,
                ayathNumber: bookmarkAyath.ayahNo,
                surah: {'surath_no': surahNo, "en_surath_name": surahName},
              ),
            ));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors.lightGray,
        ),
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: ayathText(
                  text: bookmarkAyath.ayah,
                  textAlign: TextAlign.end,
                  style: CustomFontStyle().common(
                    color: AppColors.textBlack,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                  )),
            ),
            Divider(height: 20),
            Html(
              data: bookmarkAyath.translation3,
              shrinkWrap: true,
              style: {
                "body": Style(
                  fontFamily: 'Manrope',
                  color: AppColors.textBlack,
                  fontSize: FontSize(15.sp),
                  textAlign: TextAlign.start,
                ),
              },
            ),
            Divider(height: 20),
            ayathText(
                text: bookmarkAyath.translation1,
                style: CustomFontStyle().common(
                  color: AppColors.textBlack,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                )),
            Divider(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      ImageStrings.ayathCircle,
                      height: 30.w,
                      width: 30.w,
                    ),
                    Text(
                      convertToArabic(bookmarkAyath.ayahNo),
                      style: CustomFontStyle().common(
                        color: AppColors.textBlack,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                buttonIcon(
                  icons: const Icon(Icons.bookmark,
                      color: AppColors.secondaryGreen),
                  onTap: () {
                    context
                        .read<DbProvider>()
                        .removeBookMark(
                          ayathNo: bookmarkAyath.ayahNo,
                          surahNo: surahNo,
                        )
                        .then((value) {
                      if (value) {
                        context.read<DbProvider>().removeAyath(
                            surahNo: surahNo, bookmarkAyath: bookmarkAyath);
                      }
                    });
                  },
                ),
                buttonIcon(
                  icons:
                      const Icon(Icons.share, color: AppColors.secondaryGreen),
                  onTap: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
