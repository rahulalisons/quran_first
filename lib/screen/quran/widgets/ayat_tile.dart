import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:quran_first/controller/quran_provider.dart';

import '../../../core/values/colors.dart';
import '../../common_widgets/custom_textstyle.dart';

class AyatTile extends StatelessWidget {
  const AyatTile({super.key});

  @override
  Widget build(BuildContext context) {
    bool transliteration = context.watch<QuranProvider>().showTransliteration!;
    bool translation = context.watch<QuranProvider>().showTranslation!;

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.white),
      width: double.infinity,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
              alignment: Alignment.topRight,
              child:
                  ayathText(text: 'بِسْمِ ٱللَّهِ ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ')),
          transliteration == true
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(
                      height: 20,
                    ),
                    ayathText(text: 'Bismillah hir rahman nir raheem'),
                  ],
                )
              : SizedBox(),
          translation == true
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(
                      height: 20,
                    ),
                    ayathText(
                        text:
                            'In the Name of Allah, Most Gracious,Most Merciful.'),
                  ],
                )
              : SizedBox(),
          Divider(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '1',
                style: CustomFontStyle().common(
                  color: AppColors.textBlack.withOpacity(.25),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer(),
              buttonIcon(),
              buttonIcon(icons: Icon(Icons.bookmark)),
              buttonIcon(icons: Icon(Icons.share)),
            ],
          )
        ],
      ),
    );
  }
}

Widget ayathText({String? text, TextAlign? textAlign}) {
  return Consumer<QuranProvider>(builder: (context, size, _) {
    return Text(
      textAlign: textAlign ?? TextAlign.start,
      text ?? 'In the Name of Allah, Most Gracious,Most Merciful.',
      style: CustomFontStyle().common(
        color: AppColors.textBlack,
        fontSize: size.ayatTextSize ?? 15.sp,
        fontWeight: FontWeight.w500,
      ),
    );
  });
}

Widget buttonIcon({void Function()? onTap, Widget? icons}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: InkWell(
      onTap: onTap,
      child: icons ?? Icon(Icons.play_arrow_rounded),
    ),
  );
}
