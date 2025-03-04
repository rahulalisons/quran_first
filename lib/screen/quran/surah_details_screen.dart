import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:quran_first/controller/quran_provider.dart';
import 'package:quran_first/core/values/colors.dart';
import 'package:quran_first/core/values/strings.dart';
import 'package:quran_first/screen/common_widgets/custom_button.dart';
import 'package:quran_first/screen/quran/widgets/ayat_tile.dart';
import 'package:quran_first/screen/quran/widgets/translation_switch.dart';

import '../common_widgets/custom_textstyle.dart';

class SurahDetailsScreen extends StatelessWidget {
  final Map<String, dynamic>? verses;
  final Map<String, dynamic>? enSurah;
  final Map<String, dynamic>? arSurah;
  const SurahDetailsScreen(
      {super.key, this.verses, this.enSurah, this.arSurah});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGray,
      // bottomNavigationBar: Container(
      //   height: 200.h,
      //   color: Colors.red,
      // ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.transparent,
        title: Column(
          mainAxisSize: MainAxisSize
              .min, // Important to prevent the column from taking full height
          children: [
            Text(
              '${enSurah?['surath_no']}. ${enSurah!['surath_name']}',
              style: CustomFontStyle().common(
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp,
                  color: AppColors.textBlack),
            ),
            Text(
              'The Opening',
              style: CustomFontStyle().common(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                  color: AppColors.textBlack.withOpacity(0.6)),
            ),
          ],
        ),
        actions: [
          Image.asset(
            ImageStrings.settings,
            height: 23.w,
            width: 23.w,
            color: AppColors.textBlack,
          ),
          SizedBox(
            width: 16,
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            color: AppColors.white,
            child: Column(
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 13.h),
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColors.lightGreen),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10.w,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${arSurah!['surath_name']}',
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
                            Text(
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
                      Expanded(
                          child: CustomButton(
                        borderColor: AppColors.secondaryGreen,
                        bgColor: AppColors.secondaryGreen,
                        text: 'Play Surah',
                        onPress: () {},
                        rightIcon: Expanded(
                            child: Icon(
                          Icons.play_arrow_rounded,
                          color: AppColors.white,
                        )),
                      )),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Translation Language',
                        style: CustomFontStyle().common(
                          color: AppColors.textBlack.withOpacity(0.6),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        context.read<QuranProvider>().ayathBySurath(surahNo: enSurah?['surath_no'],code: 'ma');
                      },
                      child: Text(
                        'English',
                        style: CustomFontStyle().common(
                          color: AppColors.textBlack,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Consumer<QuranProvider>(builder: (context, data, _) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: TranslationSwitch(
                          switchOnOff: data.showTransliteration!,
                          onTap: (va) {
                            data.switchOptions(value: va);
                          },
                        )),
                        TranslationSwitch(
                          title: 'Translation',
                          switchOnOff: data.showTranslation!,
                          onTap: (va) {
                            data.switchOptions(value: va, isTranslation: false);
                          },
                        )
                      ],
                    );
                  }),
                ),
              ],
            ),
          ),
          // Row(
          //   children: [
          //     CloseButton(
          //       onPressed: () {
          //         context.read<QuranProvider>().changeTextSize(size: 25.sp);
          //
          //       },
          //     ),
          //     CloseButton(
          //       onPressed: () {
          //         context.read<QuranProvider>().changeTextSize(size: 30.sp);
          //       },
          //     ),
          //     CloseButton(
          //       onPressed: () {
          //         context.read<QuranProvider>().changeTextSize(size: 20.sp);
          //       },
          //     ),
          //   ],
          // ),
          Expanded(
            child: Consumer<QuranProvider>(builder: (context, data, _) {
              return ListView.separated(
                  padding: EdgeInsets.all(16),
                  itemBuilder: (context, index) {
                    return AyatTile(
                      arAyathBysurath: data.arAyathBysurath![index],
                      index: index,

                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(
                        height: 10,
                      ),
                  itemCount: data.arAyathBysurath?.length ?? 0);
            }),
          )
        ],
      ),
    );
  }
}
