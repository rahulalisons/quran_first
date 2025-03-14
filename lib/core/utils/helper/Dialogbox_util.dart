import 'package:flutter/material.dart';

Future dialogBox(
    {BuildContext? context,
    List<Widget>? actions,
    Widget? title,
    Widget? content}) {
  return showDialog<void>(
    useSafeArea: true,
    context: context!,
    builder: (BuildContext context) {
      return AlertDialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 16),
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.white,
          contentPadding: EdgeInsets.zero,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: title ?? const SizedBox(),
          titlePadding:  EdgeInsets.zero,
          content: content ??
              const Text(
                'A dialog is a type of modal window that\n'
                'appears in front of app content to\n'
                'provide critical information, or prompt\n'
                'for a decision to be made.',
              ),
          actions: actions);
    },
  );
}
