import 'package:flutter/material.dart';

void bottomSheet(
    {BuildContext? context,
    Widget? content,
    bool? isDismissible,
    bool enableDrag = true}) {
  showModalBottomSheet(
    showDragHandle: true,
    enableDrag: enableDrag,
    isDismissible: isDismissible ?? true,
    backgroundColor: Colors.white,
    shape: const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15))),
    useSafeArea: true,
    isScrollControlled: true,
    context: context!,
    builder: (BuildContext ctx) {
      return content!;
    },
  );
}
