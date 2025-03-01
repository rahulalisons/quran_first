import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/values/colors.dart';
import 'custom_textstyle.dart';

class CustomButton extends StatelessWidget {
  final Function()? onPress;
  final bool isLoading;
  final String text;
  final Color? bgColor;
  final Color? borderColor;
  final Color? textColor;
  final TextStyle? textStyle;
  final Size? size;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final BorderRadiusGeometry? borderRadius;
  final Color? disabledBackgroundColor;

  const CustomButton(
      {this.onPress,
      required this.text,
      super.key,
      this.bgColor,
      this.rightIcon,
      this.borderColor,
      this.isLoading = false,
      this.textStyle,
      this.textColor,
      this.leftIcon,
      this.borderRadius,
      this.disabledBackgroundColor,
      this.size});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        disabledBackgroundColor: disabledBackgroundColor ?? Colors.grey[350],
        elevation: 0,
        minimumSize: size ?? Size(ScreenUtil().screenWidth, 48),
        backgroundColor: bgColor ?? AppColors.primary,
        shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(8.r),
            side: BorderSide(
              color: borderColor ?? AppColors.primary,
            )),
      ),
      onPressed: isLoading ? null : onPress,
      child: isLoading
          ? const SizedBox(
              height: 48,
              child:
                  Center(child: CircularProgressIndicator(color: Colors.white)))
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                leftIcon ?? const SizedBox(),
                SizedBox(width: leftIcon == null ? 0 : 10),
                Text(
                  text,
                  style: textStyle ??
                      CustomFontStyle().common(
                        color: textColor ?? AppColors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                SizedBox(width: rightIcon == null ? 0 : 10),
                rightIcon ?? const SizedBox(),
              ],
            ),
    );
  }
}
