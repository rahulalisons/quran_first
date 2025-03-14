import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:quran_first/screen/bookmark/widget/bookmark_tile.dart';
import 'package:quran_first/screen/bookmark/widget/empty_bookmark.dart';
import '../../controller/db_provider.dart';
import '../../core/values/colors.dart';
import '../../core/values/strings.dart';
import '../common_widgets/custom_textstyle.dart';

class Bookmark extends StatelessWidget {
  const Bookmark({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DbProvider>(context, listen: false).fetchBookmarkedAyath();
    });
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
        body: Consumer<DbProvider>(builder: (context, book, _) {
          return book.isLoadingBk == true
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : (book.bookmarkedAyath?.length ?? 0) > 0
                  ?
                  // (book.bookmarkedAyath!
                  //                 .every((surha) => surha.bookmarks.isNotEmpty))
                  //             ?
                  ListView.separated(
                      padding: EdgeInsets.all(16),
                      itemBuilder: (context, index) {
                        var data = book.bookmarkedAyath![index];
                        return data.bookmarks.isNotEmpty
                            ? Container(
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
                                  tilePadding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data.surahName ?? '',
                                        style: CustomFontStyle().common(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16.sp,
                                          color: AppColors.textBlack,
                                        ),
                                      ),
                                      Text(
                                        '${data.bookmarks.length} Bookmarks',
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
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        separatorBuilder: (context, index) =>
                                            const SizedBox(height: 10),
                                        shrinkWrap: true,
                                        itemBuilder: (context, index2) {
                                          return BookmarkTile(
                                            surahName: data.surahName,
                                            surahNo: data.surahNo,
                                            bookmarkAyath:
                                                data.bookmarks[index2],
                                          );
                                        },
                                        itemCount: data.bookmarks.length ?? 0,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : SizedBox.shrink();
                      },
                      separatorBuilder: (context, index) => SizedBox(
                            height: 10,
                          ),
                      itemCount: book.bookmarkedAyath?.length ?? 0)
                  : EmptyBookmark();
          // : EmptyBookmark();
        }));
  }
}
