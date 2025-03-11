// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../screen/common_widgets/custom_textstyle.dart';
import '../../values/colors.dart';

Future dialogBox(
    {BuildContext? context,
    List<Widget>? actions,
    Widget? title,
    EdgeInsetsGeometry? tilePadding,
    Widget? content,
    EdgeInsetsGeometry? contentPadding,
    bool barrierDismissible = true}) {
  return showDialog<void>(
    useRootNavigator: false,
    useSafeArea: true,
    context: context!,
    barrierDismissible: barrierDismissible,
    builder: (BuildContext context) {
      return SizedBox(
        child: AlertDialog(
            insetPadding:
                const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
            surfaceTintColor: Colors.transparent,
            backgroundColor: AppColors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: title ?? const SizedBox(),
            titlePadding: tilePadding ??
                const EdgeInsets.only(top: 24, right: 24, left: 24),
            content: content ??
                const Text('A dialog is a type of modal window that\n'
                    'appears in front of app content to\n'),
            contentPadding: contentPadding ?? EdgeInsets.zero,
            actions: actions),
      );
    },
  );
}

Future cancelOrder(
    {BuildContext? context,
    String? title,
    void Function()? submit,
    void Function()? back,
    bool canEdit = true}) {
  return dialogBox(
      title: Text(
        title ?? '',
        textAlign: TextAlign.center,
        style: CustomFontStyle().common(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.textBlack),
      ),
      context: context,
      contentPadding: const EdgeInsets.all(12),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(
            endIndent: 20,
            indent: 20,
          ),
          SizedBox(
            height: 20.h,
          ),
          canEdit == true
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: submit,
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        width: 80.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: AppColors.primary,
                        ),
                        child: Text(
                          'Yes',
                          style: CustomFontStyle().common(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context!);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        width: 80.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.white,
                            border: Border.all(color: AppColors.primary)),
                        child: Text(
                          'No',
                          style: CustomFontStyle().common(
                              fontFamily: "Manrope",
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary),
                        ),
                      ),
                    )
                  ],
                )
              : const SizedBox(),
          canEdit == false
              ? InkWell(
                  onTap: back ??
                      () {
                        Navigator.pop(context!);
                      },
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    width: 80.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.white,
                        border: Border.all(color: AppColors.primary)),
                    child: Text(
                      'Back',
                      style: CustomFontStyle().common(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary),
                    ),
                  ),
                )
              : const SizedBox()
        ],
      ));
}
