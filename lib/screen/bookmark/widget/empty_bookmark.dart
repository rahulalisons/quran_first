import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/values/colors.dart';
import '../../../core/values/strings.dart';
import '../../common_widgets/custom_textstyle.dart';

class EmptyBookmark extends StatelessWidget {
  const EmptyBookmark({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          SizedBox(
            height: ScreenUtil().screenHeight / 6,
          ),
          Expanded(
            child: Image.asset(
              ImageStrings.noBookMark,
            ),
          ),
          Text(
            textAlign: TextAlign.center,
            'When you Bookmark a Verse\n you will see it here',
            style: CustomFontStyle().common(
              fontWeight: FontWeight.w600,
              fontSize: 20.sp,
              color: AppColors.textBlack.withOpacity(0.7),
            ),
          ),
          SizedBox(
            height: ScreenUtil().screenHeight / 6,
          ),
        ],
      ),
    );
  }
}
