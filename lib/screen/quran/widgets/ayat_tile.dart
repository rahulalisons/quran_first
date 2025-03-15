import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:quran_first/controller/db_provider.dart';
import 'package:quran_first/controller/quran_provider.dart';

import '../../../core/values/colors.dart';
import '../../../core/values/strings.dart';
import '../../../models/arbic_script_model.dart';
import '../../common_widgets/custom_textstyle.dart';
import '../../share_screen.dart';

class AyatTile extends StatefulWidget {
  final ayath;
  const AyatTile({super.key, this.ayath});

  @override
  State<AyatTile> createState() => _AyatTileState();
}

class _AyatTileState extends State<AyatTile> {
  String? bookmarked;
  @override
  void initState() {
    // TODO: implement initState
    bookmarked = widget.ayath['is_bookmarked'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool transliteration = context.watch<QuranProvider>().showTransliteration!;
    bool translation = context.watch<QuranProvider>().showTranslation!;
    ArabicScript script = context.watch<QuranProvider>().defaultType!;
    ArabicScript font = context.watch<QuranProvider>().defaultFontSize!;

    return Consumer<QuranProvider>(builder: (context, data, _) {
      return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.white),
        width: double.infinity,
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: ayathText(
                textAlign: TextAlign.end,
                text: '${widget.ayath['arabic_ayath']}',
                style: CustomFontStyle().common(
                  color: AppColors.textBlack,
                  fontSize: font.size?.sp ?? 15.sp,
                  fontFamily: script.fontName,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            transliteration == true
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(
                        height: 20,
                      ),
                      Html(
                        data: widget.ayath['english_ayath_translator_3'],
                        shrinkWrap: true,
                        style: {
                          "body": Style(
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Manrope',
                              color: AppColors.textBlack,
                              fontSize: FontSize(font.size?.sp ?? 15.sp),
                              textAlign: TextAlign.start),
                        },
                      ),
                    ],
                  )
                : SizedBox(),
            translation == true
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: ayathText(
                            text:
                                widget.ayath['malayalam_ayath_translator_1'] ??
                                    widget.ayath['english_ayath_translator_1']),
                      ),
                    ],
                  )
                : SizedBox(),
            Divider(
              height: 20,
            ),
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
                      convertToArabic(widget.ayath['ayath_no']),
                      style: CustomFontStyle().common(
                        color: AppColors.textBlack,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                widget.ayath['juzh_no'] != null
                    ? Text(
                        widget.ayath['juzh_no'].toString(),
                        style: CustomFontStyle().common(
                          color: AppColors.textBlack,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    : SizedBox(),
                Spacer(),
                buttonIcon(onTap: () {
                  context.read<DbProvider>().clearBookMark();
                }),
                buttonIcon(
                    icons: bookmarked == "true"
                        ? Icon(Icons.bookmark)
                        : Icon(Icons.bookmark_border),
                    onTap: bookmarked != "true"
                        ? () {
                            print('asdaqwd');
                            context
                                .read<DbProvider>()
                                .addBookMark(
                                  ayathNo: widget.ayath['ayath_no'],
                                  ayath: widget.ayath['arabic_ayath'],
                                  surahNo: widget.ayath['surath_no'],
                                  translation: widget.ayath[
                                          'malayalam_ayath_translator_1'] ??
                                      widget
                                          .ayath['english_ayath_translator_1'],
                                )
                                .then(
                              (value) {
                                print('add sucee--$value');
                                if (value) {
                                  setState(() {
                                    bookmarked = 'true';
                                  });
                                }
                              },
                            );
                          }
                        : () {
                            context
                                .read<DbProvider>()
                                .removeBookMark(
                                    ayathNo: widget.ayath['ayath_no'],
                                    surahNo: widget.ayath['surath_no'])
                                .then(
                              (value) {
                                if (value) {
                                  setState(() {
                                    bookmarked = 'false';
                                  });
                                }
                              },
                            );
                          }),
                buttonIcon(
                    icons: Icon(Icons.share),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShareScreen(
                              ayath: widget.ayath,
                            ),
                          ));
                    }),
              ],
            )
          ],
        ),
      );
    });
  }
}

String convertToArabic(int number) {
  return number.toString().split('').map((digit) {
    return String.fromCharCode(
        0x0660 + int.parse(digit)); // Arabic numeral Unicode
  }).join();
}

Widget ayathText({String? text, TextAlign? textAlign, TextStyle? style}) {
  return Consumer<QuranProvider>(builder: (context, size, _) {
    return Text(
      textAlign: textAlign ?? TextAlign.start,
      text ?? 'In the Name of Allah, Most Gracious,Most Merciful.',
      style: style ??
          CustomFontStyle().common(
            color: AppColors.textBlack,
            fontSize: size.defaultFontSize?.size?.sp ?? 15.sp,
            fontWeight: FontWeight.w500,
          ),
    );
  });
}

Widget buttonIcon({void Function()? onTap, Widget? icons}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: InkWell(
      onTap: onTap,
      child: icons ?? Icon(Icons.play_arrow_rounded),
    ),
  );
}
