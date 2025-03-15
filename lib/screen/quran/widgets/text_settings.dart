import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:quran_first/controller/quran_provider.dart';
import 'package:quran_first/screen/quran/widgets/translation_switch.dart';
import 'package:quran_first/screen/quran/widgets/trasnsiteration_translation.dart';

import '../../../core/values/colors.dart';
import '../../common_widgets/custom_textstyle.dart';

class TextSettings extends StatelessWidget {
  const TextSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<QuranProvider>(builder: (context, settings, _) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Arabic Script',
              maxLines: 1,
              style: CustomFontStyle().common(
                color: AppColors.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          SizedBox(
            height: 105.h,
            child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  var data = settings.arabicType[index];
                  return SizedBox(
                    width: 75.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            InkWell(
                              onTap: () {
                                settings.changeScript(data);
                              },
                              child: Container(
                                width: 75.w,
                                height: 75.w,
                                decoration: BoxDecoration(
                                    color: AppColors.lightGray,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        width: 2,
                                        color:
                                            settings.defaultType?.id == data.id
                                                ? AppColors.secondaryGreen
                                                : AppColors.transparent)),
                                alignment: Alignment.center,
                                child: Text(
                                  'بسم الله',
                                  style: CustomFontStyle().common(
                                    color: AppColors.textBlack,
                                    fontFamily: data.fontName,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                            settings.defaultType?.id == data.id
                                ? Positioned(
                                    right: 0.w,
                                    child: Icon(
                                      Icons.check_circle,
                                      color: AppColors.checkGreen,
                                      size: 18.sp,
                                    ),
                                  )
                                : SizedBox.shrink()
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          data.displayName ?? '',
                          textAlign: TextAlign.center,
                          style: CustomFontStyle().common(
                            color: AppColors.textBlack.withOpacity(0.7),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(
                      width: 10,
                    ),
                itemCount: settings.arabicType.length),
          ),
          TransliterationTranslation(
            isFromSettings: true,
          )
        ],
      );
    });
  }
}
