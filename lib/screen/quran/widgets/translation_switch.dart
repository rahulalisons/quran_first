import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/values/colors.dart';
import '../../../core/values/strings.dart';
import '../../common_widgets/custom_textstyle.dart';

class TranslationSwitch extends StatelessWidget {
  bool switchOnOff;
  final String? title;
  final void Function(bool)? onTap;
  final bool? isFomSettings;
  TranslationSwitch(
      {super.key,
      this.title,
      this.onTap,
      required this.switchOnOff,
      this.isFomSettings = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        isFomSettings != true
            ? Text(
                title ?? 'Transliteration',
                style: CustomFontStyle().common(
                  color: isFomSettings != true
                      ? AppColors.textBlack.withOpacity(0.6)
                      : AppColors.textBlack,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              )
            : Expanded(
                child: Text(title ?? 'Transliteration',
                    style: CustomFontStyle().common(
                      color: isFomSettings != true
                          ? AppColors.textBlack.withOpacity(0.6)
                          : AppColors.textBlack,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ))),
        SizedBox(
          width: 10,
        ),

        InkWell(
          onTap: () {
            onTap!(switchOnOff = !switchOnOff);
          },
          child: SizedBox(
            width: 40,
            height: 30,
            child: SvgPicture.asset(
              switchOnOff == true
                  ? SvgSting.translationSwitchOn
                  : SvgSting.translationSwitchOff,
              fit: BoxFit.scaleDown,
            ),
          ),
        )
      ],
    );
  }
}
