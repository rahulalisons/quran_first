import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quran_first/controller/quran_provider.dart';
import 'package:quran_first/screen/common_widgets/custom_textfield.dart';
import 'package:timer_builder/timer_builder.dart';

import '../../core/values/colors.dart';
import '../../core/values/strings.dart';
import '../common_widgets/custom_textstyle.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var ctrl = Provider.of<QuranProvider>(context);
    var size = MediaQuery.of(context).size;
    HijriCalendar.setLocal('en');
    var today = HijriCalendar.now();

    String formattedDate =
        "${today.hDay} ${today.longMonthName}, ${today.hYear} AH";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondaryGreen,
        title: Text(
          'Quranfirst',
          style: CustomFontStyle().common(
            color: AppColors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
        elevation: 0,
        actions: [
          InkWell(
            onTap: () {
              context.read<QuranProvider>().bottomnaviagtionSwitch(3);
            },
            child: Image.asset(
              ImageStrings.more,
              width: 30,
              height: 30,
              color: AppColors.white,
            ),
          ),
          SizedBox(
            width: 15.w,
          )
        ],
      ),
      body: Container(
        color: AppColors.white,
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      'assets/app/images/home_top_image.png',
                    ),
                    fit: BoxFit.fill),
              ),
              width: size.width,
              height: size.height / 2.7,
              padding: EdgeInsets.symmetric(horizontal: 10),
              clipBehavior: Clip.none,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: AppColors.white,
                          ),
                          Text(
                            '${ctrl.currentLocations!.first.subAdministrativeArea == '' ? ctrl.currentLocations!.first.locality : ctrl.currentLocations!.first.subAdministrativeArea}, ${ctrl.currentLocations!.first.administrativeArea}',
                            style: CustomFontStyle().common(
                              color: AppColors.white,
                              fontSize: size.width * 0.04,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        formattedDate,
                        style: CustomFontStyle().common(
                          color: AppColors.white,
                          fontSize: size.width * 0.035,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      TimerBuilder.periodic(Duration(seconds: 1),
                          builder: (context) {
                        return Text(
                          getSystemTime(),
                          style: CustomFontStyle().common(
                            color: AppColors.white,
                            fontSize: size.width * 0.1,
                            fontWeight: FontWeight.w600,
                          ),
                        );
                      }),
                    ],
                  ),
                  Positioned(
                    top: size.height / 4.1,
                    child: Container(
                      height: 180.h,
                      width: 330.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/app/images/home_screen_surah.png',
                            ),
                            fit: BoxFit.fill,
                          )),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: 250.w,
                            child: Column(
                              children: [
                                Text(
                                  '(الله) الرحمن! إنه هو الذي علم القرآن',
                                  textAlign: TextAlign.center,
                                  style: CustomFontStyle().common(
                                    color: AppColors.white,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  '(Allah) Most Gracious! It is He Who has taught the Quran',
                                  textAlign: TextAlign.center,
                                  style: CustomFontStyle().common(
                                    color: AppColors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  'Surah Ar Rahman 1 - 2',
                                  style: CustomFontStyle().common(
                                    color: AppColors.white,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 110.h,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          buildGridItem(onTap: () {
                            context
                                .read<QuranProvider>()
                                .bottomnaviagtionSwitch(1);
                          }),
                          SizedBox(
                            width: 20.w,
                          ),
                          buildGridItem(
                              onTap: () {
                                context
                                    .read<QuranProvider>()
                                    .bottomnaviagtionSwitch(2);
                              },
                              title: 'Prayer Times',
                              icon: 'assets/app/images/home_prayer_time.png')
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.w,
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          buildGridItem(
                              onTap: () {},
                              icon: 'assets/app/images/home_qibla.png',
                              title: 'Find Qibla'),
                          SizedBox(
                            width: 20.w,
                          ),
                          buildGridItem(
                              onTap: () {},
                              title: 'Bookmarks',
                              icon: 'assets/app/images/home_bookmark.png')
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            )
          ],
        ),
      ),
    );
  }

  String getSystemTime() {
    var now = DateTime.now();
    return DateFormat("h:mm a").format(now); // 12-hour format with AM/PM
  }

  Widget buildGridItem({String? icon, String? title, void Function()? onTap}) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          // margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.lightGreen,
            borderRadius: BorderRadius.circular(12),
          ),
          // padding: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                icon ?? 'assets/app/images/home_quran.png',
                width: 60.w,
                height: 60.w,
              ),
              SizedBox(height: 5.h),
              Text(
                title ?? 'Read Quran',
                style: CustomFontStyle().common(
                  color: AppColors.textBlack,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
