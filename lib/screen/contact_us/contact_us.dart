import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_first/screen/contact_us/widgets/social_button.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../core/values/colors.dart';
import '../../core/values/constants.dart';
import '../../core/values/strings.dart';
import '../common_widgets/custom_appbar.dart';
import '../common_widgets/custom_textstyle.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: PreferredSize(
          preferredSize: Size(ScreenUtil().screenWidth, 50),
          child: CustomAppbar(
            title: 'Contact Us',
            actions: [],
          )),
      body: SizedBox(
        width: ScreenUtil().screenWidth,
        height: ScreenUtil().screenHeight,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Container(
                constraints: BoxConstraints(
                    maxHeight: 210.h, minWidth: ScreenUtil().screenWidth),
                decoration: BoxDecoration(
                  color: Color(0xFFE9F3EC),
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                        top: -50,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: AppColors.lightGreen),
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(50)),
                          width: 60.w,
                          height: 60.w,
                          child: Icon(
                            Icons.location_on,
                            color: AppColors.secondaryGreen,
                            size: 25,
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Text(
                        textAlign: TextAlign.center,
                        'Alisons Infomatics (P) Ltd.\nKaoser Complex \nCaltex Junction, Kannur \nKerala, India',
                        style: CustomFontStyle().common(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
                            color: AppColors.textBlack,
                            height: 2),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                textAlign: TextAlign.center,
                'Follow us on',
                style: CustomFontStyle().common(
                  fontWeight: FontWeight.w600,
                  fontSize: 20.sp,
                  color: AppColors.secondaryGreen,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SocialButton(
                    onTap: () async {
                      await launchInstagram(
                          'https://www.instagram.com/alisons.infomatics?igsh=MTFqajlldjZnYmNuaA==');
                    },
                  ),
                  SocialButton(
                    onTap: () async {
                      await launchFaceBook(
                          'https://www.facebook.com/Alisonsinfo/');
                    },
                    image: ImageStrings.faceBook,
                  ),
                  SocialButton(
                    onTap: () async {
                      await launchUrlString(
                          'https://x.com/i/flow/login?redirect_after_login=%2Falisonsgroup');
                    },
                    image: ImageStrings.twitter,
                  ),
                  SocialButton(
                    onTap: () async {
                      await launchUrlString(
                          'https://www.linkedin.com/company/alisonsinfomatics/posts/?feedView=all');
                    },
                    image: ImageStrings.linkedIn,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
