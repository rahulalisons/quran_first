import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quran_first/controller/db_provider.dart';
import 'package:quran_first/screen/quran/widgets/ayat_tile.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/values/colors.dart';
import '../../core/values/strings.dart';
import 'common_widgets/custom_button.dart';
import 'common_widgets/custom_textstyle.dart';

class ShareScreen extends StatelessWidget {
  final Map<String, dynamic> ayath;
  const ShareScreen({super.key, required this.ayath});

  @override
  Widget build(BuildContext context) {
    bool isSharing = context.watch<DbProvider>().isSharing;

    return Scaffold(
      body: Screenshot(
        controller: context.read<DbProvider>().screenshotController,
        child: Container(
          height: ScreenUtil().screenHeight,
          width: ScreenUtil().screenWidth,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primary, const Color(0xFF07170D)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Image.asset(ImageStrings.splashStar),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white),
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '${ayath['arabic_surath_name']} ',
                          style: CustomFontStyle().common(
                              fontWeight: FontWeight.w600,
                              fontSize: 18.sp,
                              color: AppColors.textBlack),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Verse ${ayath['ayath_no']} ',
                          style: CustomFontStyle().common(
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp,
                              color: AppColors.textBlack.withOpacity(0.5)),
                        ),
                        SizedBox(height: 20.h),
                        Align(
                          alignment: Alignment.topRight,
                          child: ayathText(
                            textAlign: TextAlign.end,
                            style: CustomFontStyle().common(
                              color: AppColors.textBlack,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            text: '${ayath['arabic_ayath']}',
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Divider(height: 20),
                            Html(
                              data: ayath['english_ayath_translator_3'],
                              shrinkWrap: true,
                              style: {
                                "body": Style(
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Manrope',
                                    color: AppColors.secondaryGreen,
                                    fontSize: FontSize(15.sp),
                                    textAlign: TextAlign.start),
                              },
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Divider(height: 20),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: ayathText(
                                  text: ayath[
                                          'malayalam_ayath_translator_1'] ??
                                      ayath['english_ayath_translator_1']),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  isSharing != true
                      ? Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: CustomButton(
                            borderRadius: BorderRadius.circular(50),
                            bgColor: AppColors.shareBColor,
                            borderColor: AppColors.shareBColor,
                            text: 'Share',
                            onPress: (){
                              context.read<DbProvider>().captureAndShare();
                            },
                          ),
                        )
                      : SizedBox(
                          height: 75.h,
                        ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: ScreenUtil().statusBarHeight),
                child: IconButton(
                  color: isSharing != true
                      ? AppColors.white
                      : AppColors.transparent,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
