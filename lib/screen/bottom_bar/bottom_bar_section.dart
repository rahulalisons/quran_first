import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:quran_first/controller/quran_provider.dart';
import 'package:quran_first/core/values/strings.dart';

import '../../core/values/colors.dart';
import '../common_widgets/custom_textstyle.dart';

class BottomBarSection extends StatelessWidget {
  const BottomBarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Consumer<QuranProvider>(builder: (context, dashBoard, _) {
        return Scaffold(
          body: dashBoard.pages[dashBoard.selectedIndex],
          bottomNavigationBar: dashBoard.selectedIndex == 0
              ? null
              : Container(
            color: AppColors.red,
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              onTap: (index) => dashBoard.bottomnaviagtionSwitch(index),
              elevation: 0,
              currentIndex: dashBoard.selectedIndex,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              backgroundColor: AppColors.white,
              selectedItemColor: AppColors.secondaryGreen,
              selectedLabelStyle: CustomFontStyle().common(
                color: AppColors.secondaryGreen,
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
              ),
              unselectedLabelStyle: CustomFontStyle().common(
                color: AppColors.bottomBarUnSelectColor,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
              unselectedItemColor: AppColors.bottomBarUnSelectColor,
              selectedIconTheme: const IconThemeData(
                color: AppColors.secondaryGreen,
              ),
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Image(
                    image: AssetImage(ImageStrings.home),
                    height: 25,
                    width: 25,
                    color: AppColors.bottomBarUnSelectColor,
                  ),
                  activeIcon: Image(
                    image: AssetImage(ImageStrings.home),
                    height: 25,
                    width: 25,
                    color: AppColors.secondaryGreen,
                  ),
                  label: "Home",
                ),
                const BottomNavigationBarItem(
                  icon: Image(
                    image: AssetImage(ImageStrings.quran),
                    height: 30,
                    width: 30,
                    color: AppColors.bottomBarUnSelectColor,
                  ),
                  activeIcon: Image(
                    image: AssetImage(ImageStrings.quran),
                    height: 30,
                    width: 30,
                    color: AppColors.secondaryGreen,
                  ),
                  label: "Quran",
                ),
                const BottomNavigationBarItem(
                  icon: Image(
                    image: AssetImage(ImageStrings.prayer),
                    height: 25,
                    width: 25,
                    color: AppColors.bottomBarUnSelectColor,
                  ),
                  activeIcon: Image(
                    image: AssetImage(ImageStrings.prayer),
                    height: 25,
                    width: 25,
                    color: AppColors.secondaryGreen,
                  ),
                  label: "Prayer",
                ),
                const BottomNavigationBarItem(
                  icon: Image(
                    image: AssetImage(ImageStrings.more),
                    height: 25,
                    width: 25,
                    color: AppColors.bottomBarUnSelectColor,
                  ),
                  activeIcon: Image(
                    image: AssetImage(ImageStrings.more),
                    height: 25,
                    width: 25,
                    color: AppColors.secondaryGreen,
                  ),
                  label: "More",
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
