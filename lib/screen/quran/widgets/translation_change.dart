import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/helper/Dialogbox_util.dart';
import '../../../core/values/colors.dart';
import '../../../models/translator_model.dart';
import '../../common_widgets/custom_textstyle.dart';

void changeTraslation(
    {BuildContext? context,
    List<Translator>? translator,
    Translator? selectedTranslator,
    void Function(Translator)? onTap}) {
  dialogBox(
    context: context,
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 16, bottom: 8),
          child: Text(
            "Translation Language",
            style: CustomFontStyle().common(
              color: AppColors.textBlack,
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Divider()
      ],
    ),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        translator?.length ?? 0,
        (index) {
          bool isLastItem = index == (translator!.length - 1);
          return Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: InkWell(
                  onTap: () {
                    if (onTap != null) {
                      onTap(translator[
                          index]); // Pass the selected option to onTap
                    }
                    Navigator.pop(context!);
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: ScreenUtil().screenWidth / 4.8,
                        child: Text(
                          translator[index].language,
                          style: CustomFontStyle().common(
                            color: AppColors.textBlack,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Text(
                        '- ',
                        style: CustomFontStyle().common(
                          color: AppColors.textBlack,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          translator[index].name,
                          style: CustomFontStyle().common(
                            color: AppColors.textBlack.withOpacity(0.7),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      (selectedTranslator!.id == translator[index].id) &&
                              (selectedTranslator.language ==
                                  translator[index].language)
                          ? Icon(
                              Icons.radio_button_checked,
                              color: AppColors.secondaryGreen,
                            )
                          : SizedBox()
                    ],
                  ),
                ),
              ),
              if (!isLastItem) Divider(),
              if (isLastItem) SizedBox(height: 10),
            ],
          );
        },
      ),
    ),
  );
}
