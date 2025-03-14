import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_first/screen/about_us/about_us.dart';
import 'package:quran_first/screen/settings/widget/settings_tile.dart';

import '../../core/values/colors.dart';
import '../../core/values/strings.dart';
import '../common_widgets/custom_appbar.dart';
import '../common_widgets/custom_textstyle.dart';
import '../contact_us/contact_us.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: PreferredSize(
          preferredSize: Size(ScreenUtil().screenWidth, 50),
          child: CustomAppbar(
            title: 'More',
            actions: [],
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SettingsTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AboutUs(),
                      ));
                },
              ),
              SettingsTile(
                title: 'Contact Us',
                image: ImageStrings.contactUs,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ContactUs(),
                      ));
                },
              ),
              SettingsTile(
                title: 'Rate App',
                image: ImageStrings.rateApp,
              ),
              SettingsTile(
                title: 'Share App',
                image: ImageStrings.shareApp,
              ),
              SettingsTile(
                title: 'App Version ',
                action: Text(
                  'v 1.0.0',
                  style: CustomFontStyle().common(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                      color: AppColors.textBlack.withOpacity(0.5)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
