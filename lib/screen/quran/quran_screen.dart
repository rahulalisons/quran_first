import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:quran_first/controller/db_provider.dart';
import 'package:quran_first/controller/quran_provider.dart';
import 'package:quran_first/core/values/strings.dart';
import 'package:quran_first/screen/common_widgets/custom_textstyle.dart';
import 'package:quran_first/screen/quran/widgets/custom_switch.dart';
import 'package:quran_first/screen/quran/widgets/juz_list.dart';
import 'package:quran_first/screen/quran/widgets/surah_list.dart';
import 'package:quran_first/screen/quran/widgets/surah_tile.dart';

import '../../core/utils/helper/debounce.dart';
import '../../core/values/colors.dart';
import '../bookmark/bookmark.dart';
import '../common_widgets/custom_appbar.dart';
import '../common_widgets/custom_textfield.dart';

class QuranScreen extends StatelessWidget {
  const QuranScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DbProvider>().fetchAllSurath();
    });
    final debounce = Debounce(milliseconds: 500);
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: PreferredSize(
          preferredSize: Size(ScreenUtil().screenWidth, 50),
          child: CustomAppbar(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Bookmark(),));
            },

          )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomTextField(
              onChanged: (value) {
                debounce.run(() {
                  print(value);
                Provider.of<DbProvider>(context,listen: false).fetchAllSurath(search: value);
                });
              },
              minHeight: 55.h,
              hintStyle: CustomFontStyle().common(
                color: AppColors.textBlack.withOpacity(.70),
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
              readonly: false,
              filled: true,
              fillColor: AppColors.lightGreen,
              suffixIcon: Icon(Icons.search_sharp),
              borderside: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(color: AppColors.transparent)),
              hintText: '   Search by Surah Name, Number or Verse',
            ),
            // Consumer<QuranProvider>(builder: (context, data, _) {
            //   return CustomSwitch(
            //       selectIndex: data.juzOrSurah,
            //       onTap: (va) {
            //         data.switchIndex(va);
            //       },
            //       names: ['Surah', 'Juz']);
            // }),
            // SizedBox(
            //   height: 5,
            // ),
            Consumer<QuranProvider>(builder: (context, data, _) {
              return Expanded(
                  child: Visibility(
                visible: data.juzOrSurah == 0 ? true : false,
                replacement: JuzList(),
                child: SurahList(),
              ));
            })
          ],
        ),
      ),
    );
  }
}
