import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:quran_first/core/values/colors.dart';
import 'package:quran_first/screen/on_boarding/widgets/on_boarding_text.dart';
import '../../controller/quran_provider.dart';
import '../../core/values/strings.dart';
import '../bottom_bar/bottom_bar_section.dart';
import '../common_widgets/custom_button.dart';
import '../common_widgets/custom_textstyle.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: ScreenUtil().screenHeight,
        width: ScreenUtil().screenWidth,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primary, Color(0xFF07170D)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Consumer<QuranProvider>(
          builder: (context, dashboard, _) {
            print('rebuild-----888');
            return Column(
              children: [
                /// Top 'Quranfirst' Text
                Padding(
                  padding: EdgeInsets.only(top: ScreenUtil().statusBarHeight),
                  child: Text(
                    'Quranfirst',
                    style: CustomFontStyle().common(
                      color: AppColors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 30.sp,
                      height: 2,
                    ),
                  ),
                ),

                /// Spacer to push the carousel into the center area
                const Spacer(),

                /// Carousel Section
                CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: false,
                    aspectRatio: 1,
                    enableInfiniteScroll: false,
                    enlargeCenterPage: true,
                    height: ScreenUtil().screenHeight / 1.8,
                    viewportFraction: 1,
                    onPageChanged: (index, reason) {
                      dashboard.changeCurrentIndex(index: index);
                    },
                  ),
                  items: [
                    OnBoardingText(),
                    OnBoardingText(
                      titleHeight: 45.h,
                      height: 240.h,
                      image: ImageStrings.onboarding2,
                      title: 'Personalized Learning Experience',
                      subtitle:
                          'Deepen your Quranic understanding with interactive tafsir, audio recitations, and search features.',
                    ),
                    OnBoardingText(
                        titleHeight: 60.h,
                        height: 220.h,
                        image: ImageStrings.onboarding3,
                        title: 'Your Quran, Anytime, Anywhere',
                        subtitle:
                            'Seamless access to the Quran with advanced features Your journey starts now!'),
                  ],
                ),
                Spacer(),

                /// Dots Indicator
                dashboard.currentIndex == 2
                    ? Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: CustomButton(
                          onPress: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BottomBarSection()),
                              (Route<dynamic> route) =>
                                  false, // This removes all previous routes
                            );
                          },
                          bgColor: Color(0XFF336846),
                          borderRadius: BorderRadius.circular(50.r),
                          borderColor: Colors.transparent,
                          text: 'Get Started',
                        ),
                      )
                    : DotsIndicator(
                        dotsCount: 3,
                        position: dashboard.currentIndex!.toDouble(),
                        decorator: DotsDecorator(
                          activeColor: AppColors.primary,
                          color: AppColors.white.withOpacity(0.5),
                          size: const Size.square(9.0),
                          activeSize: const Size(25.0, 9.0),
                          activeShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),

                const Spacer(),

                Image.asset(
                  ImageStrings.logo,
                  width: ScreenUtil().screenWidth,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
