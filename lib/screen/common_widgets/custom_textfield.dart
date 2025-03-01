import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/values/colors.dart';
import 'custom_textstyle.dart';

class CustomTextField extends StatefulWidget {
  final void Function()? onTap;
  final void Function()? onTapSuffix;
  final void Function(String?)? onSaved;
  final void Function(String)? onChanged;
  final String? hintText;
  final bool isPasswordType;
  final int? maxLength;
  final int? maxLine;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final TextStyle? hintStyle;
  final bool readonly;
  final FocusNode? focusNode;
  final Widget? suffixIcon;
  final bool filled;
  final Color? fillColor;
  final Widget? prefixIcon;
  final String? sufixText;
  final double? minHeight;
  final InputBorder? borderside;
  final TextCapitalization textCapitalization;
  final TextStyle? style;
  const CustomTextField(
      {super.key,
      this.controller,
        this.minHeight,
      this.style,
      this.onSaved,
      this.onTap,
      this.onChanged,
      this.onTapSuffix,
      this.hintText,
      this.keyboardType,
      this.hintStyle,
      this.maxLine,
      this.validator,
      this.suffixIcon,
      this.focusNode,
      this.prefixIcon,
      this.sufixText,
      this.isPasswordType = false,
      this.readonly = false,
      this.maxLength,
      this.borderside,
      this.textCapitalization = TextCapitalization.none,
      this.fillColor = const Color(0xFFF5F5F5),
      this.filled = true});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColors.primary,
      onChanged: widget.onChanged,
      onTap: widget.onTap,
      onSaved: widget.onSaved,
      readOnly: widget.readonly,
      focusNode: widget.focusNode,
      style: widget.style ??
          CustomFontStyle().common(
              color: const Color(0xFF2C2C2C),
              fontWeight: FontWeight.w500,
              fontSize: 16.sp),
      maxLength: widget.maxLength,
      maxLines: widget.maxLine ?? 1,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      obscureText: widget.isPasswordType ? _obscureText : false,
      textCapitalization: widget.textCapitalization,
      decoration: InputDecoration(
          errorMaxLines: 4,
          counter: const SizedBox.shrink(),
          fillColor: widget.fillColor,
          filled: widget.filled ? true : false,
          contentPadding:
               EdgeInsets.symmetric(vertical: 10.0.h, horizontal: 10.0.w),
          constraints: BoxConstraints(minHeight:widget.minHeight?? 50.h),
          hintText: widget.hintText,
          suffixStyle: CustomFontStyle().common(
            color: AppColors.primary,
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
          ),
          hintStyle: widget.hintStyle ??
              CustomFontStyle().common(
                color: AppColors.textBlack.withOpacity(.70),
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                // height: 0.12,
              ),
          suffix: InkWell(
              onTap: widget.onTapSuffix, child: Text(widget.sufixText ?? "")),
          suffixIconConstraints: BoxConstraints(maxHeight: 65.h),
          prefixIcon: widget.prefixIcon,
          suffixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: widget.suffixIcon ??
                (widget.isPasswordType
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        child: Icon(
                          _obscureText
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: const Color(0xFFB5B5B5),
                        ),
                      )
                    : null),
          ),
          focusedBorder: widget.borderside ??
              OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0XFFE1E8F2))),
          errorBorder: widget.borderside ??
              OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.red)),
          focusedErrorBorder: widget.borderside ??
              OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0XFFE1E8F2))),
          enabledBorder: widget.borderside ??
              OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Color(0XFFD0DAEA),
                  ))),
    );
  }
}
