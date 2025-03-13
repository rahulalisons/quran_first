import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:quran_first/screen/quran/widgets/ayat_tile.dart';

import '../../../controller/db_provider.dart';
import '../../../core/values/colors.dart';
import '../../common_widgets/custom_textstyle.dart';

class BookmarkTile extends StatefulWidget {
  final Map<String, dynamic> ayath;
  const BookmarkTile({super.key, required this.ayath});

  @override
  State<BookmarkTile> createState() => _BookmarkTileState();
}

class _BookmarkTileState extends State<BookmarkTile> {
  int? isBookMarked;
  @override
  @override
  void initState() {
    // TODO: implement initState
    isBookMarked = widget.ayath['isBookmarked'];
    super.initState();
  }

  Widget build(BuildContext context) {
    return isBookMarked == 1
        ? Container(
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
                  child: ayathText(text: widget.ayath['ayath']),
                ),
                Divider(height: 20),
                Html(
                  data: widget.ayath['en_ayath_t3'],
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
                ayathText(text: widget.ayath['en_ayath_t1']),
                Divider(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.ayath['ayath_no']}--$isBookMarked',
                      style: CustomFontStyle().common(
                        color: AppColors.textBlack.withOpacity(.25),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    buttonIcon(
                      icons: const Icon(Icons.bookmark,
                          color: AppColors.secondaryGreen),
                      onTap: () {
                        context
                            .read<DbProvider>()
                            .removeBookMark(
                              ayathNo: widget.ayath['ayath_no'],
                              surahNo: widget.ayath['surath_no'],
                            )
                            .then((value) {
                          if (value) {
                            setState(() {
                              isBookMarked = 0;
                            });
                          }
                        });
                      },
                    ),
                    buttonIcon(
                      icons: const Icon(Icons.share,
                          color: AppColors.secondaryGreen),
                      onTap: () {},
                    ),
                  ],
                )
              ],
            ),
          )
        : SizedBox();
  }
}
