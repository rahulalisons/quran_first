import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:quran_first/controller/db_provider.dart';
import '../../../core/utils/helper/Dialogbox_util.dart';
import '../../../core/values/colors.dart';

import '../../common_widgets/custom_textstyle.dart';

void switchAya({
  BuildContext? context,
  required void Function(int index) onAyaSelected,
  String? name,
}) {
  dialogBox(
    context: context,
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 16, bottom: 8),
          child: Text(
            "$name",
            style: CustomFontStyle().common(
              color: AppColors.textBlack,
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Divider(),
      ],
    ),
    content: Consumer<DbProvider>(builder: (context, aya, _) {
      return SizedBox(
        width: ScreenUtil().screenWidth,
        height: 350.h,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              aya.surahDetails?.length ?? 0,
              (index) {
                return InkWell(
                  onTap: () {
                    onAyaSelected(aya.surahDetails![index]['ayath_no']);
                    Navigator.pop(context); // Close the dialog
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 10),
                    child: Text(
                      "Aya ${aya.surahDetails![index]['ayath_no']}",
                      style: CustomFontStyle().common(
                        color: AppColors.textBlack.withOpacity(0.7),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      );
    }),
  );
}
