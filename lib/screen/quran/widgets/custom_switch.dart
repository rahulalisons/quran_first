import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:quran_first/controller/quran_provider.dart';
import 'package:quran_first/screen/common_widgets/custom_textstyle.dart';

import '../../../core/values/colors.dart';

class CustomSwitch extends StatelessWidget {
  final List<String>? names;
  final int? selectIndex;
  final void Function(int)? onTap;
  const CustomSwitch({super.key, this.names, this.selectIndex, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color: AppColors.lightGreen),
      padding: EdgeInsets.all(8),
      width: ScreenUtil().screenWidth,
      child: Row(
        children: List.generate(
          2,
          (index) {
            return Expanded(
              child: InkWell(
                onTap: () {
                  onTap!(index);
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: selectIndex == index
                          ? AppColors.white
                          : AppColors.lightGreen),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    names![index] ?? '',
                    textAlign: TextAlign.center,
                    style: CustomFontStyle().common(
                      color: selectIndex == index
                          ? AppColors.textBlack
                          : AppColors.textBlack.withOpacity(.7),
                      fontSize: 14.sp,
                      fontWeight: selectIndex == index
                          ? FontWeight.w600
                          : FontWeight.w500,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
