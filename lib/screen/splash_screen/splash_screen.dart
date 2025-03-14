import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:quran_first/screen/on_boarding/on_boarding.dart';

import '../../controller/db_provider.dart';
import '../../controller/quran_provider.dart';
import '../../core/utils/helper/shared_preference.dart';
import '../../core/values/colors.dart';
import '../../core/values/constants.dart';
import '../../core/values/strings.dart';
import '../bottom_bar/bottom_bar_section.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _logoAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _starFadeAnimation;
  late Animation<double> _starScaleAnimation;
  late Animation<double>
      _logoScaleAnimation; // Added new scale animation for appLogo

  @override
  void initState() {
    super.initState();
    var provider = Provider.of<QuranProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DbProvider>().fetchRandomAyath();

      provider.currentLocation(context);
    });

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    // Logo sliding from bottom
    _logoAnimation = Tween<Offset>(
      begin: const Offset(0, 2), // Starts below
      end: Offset.zero, // Ends at normal position
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    // Fade-in animation for text & appLogo
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    // Splash star fade-in effect
    _starFadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    // Splash star scale effect
    _starScaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    // NEW: App logo starts small (0.1) and zooms in to normal size (1.0)
    _logoScaleAnimation = Tween<double>(begin: 0.1, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _controller.forward();
    provider.isFirstTimeOrNot(context: context);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
              alignment: Alignment.topCenter, // Positions at the top
              child: FadeTransition(
                opacity: _starFadeAnimation,
                child: ScaleTransition(
                  scale: _starScaleAnimation,
                  child: Image.asset(ImageStrings.splashStar),
                ),
              ),
            ),
            Column(
              children: [
                const Spacer(),
                SlideTransition(
                  position: _logoAnimation,
                  child: Image.asset(
                    ImageStrings.logo,
                    width: ScreenUtil().screenWidth,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: ScaleTransition(
                      scale: _logoScaleAnimation,
                      child: Image.asset(
                        ImageStrings.appLogo,
                        width: 218.w,
                        height: 280.h,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 80.h,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
