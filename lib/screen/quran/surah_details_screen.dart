import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:quran_first/controller/quran_provider.dart';
import 'package:quran_first/core/values/colors.dart';
import 'package:quran_first/core/values/strings.dart';
import 'package:quran_first/screen/common_widgets/custom_button.dart';
import 'package:quran_first/screen/quran/widgets/ayat_tile.dart';
import 'package:quran_first/screen/quran/widgets/translation_switch.dart';

import '../../controller/db_provider.dart';
import '../common_widgets/custom_textstyle.dart';

class SurahDetailsScreen extends StatefulWidget {
  final int? surathId;
  final surah;
  final int? ayathNumber;
  const SurahDetailsScreen(
      {super.key, this.surathId, this.surah, this.ayathNumber});

  @override
  State<SurahDetailsScreen> createState() => _SurahDetailsScreenState();
}

class _SurahDetailsScreenState extends State<SurahDetailsScreen> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    context.read<DbProvider>().getSurahDetail(widget.surathId!, key: 'english');
    context.read<DbProvider>().selectedLanguage = 'English';

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.ayathNumber != null && widget.ayathNumber! > 0) {
        _scrollToAyath(widget.ayathNumber!);
      } else {
        _scrollToAyath(0);
      }
    });
  }

  void _scrollToAyath(int index) {
    // Future.delayed(Duration(milliseconds: 300), () {
    //   _scrollController.animateTo(
    //     index * 60.0,
    //     duration: Duration(milliseconds: 1000),
    //     curve: Curves.easeInOut,
    //   );
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGray,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.transparent,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${widget.surah['surath_no']}. ${widget.surah['en_surath_name']}',
              style: CustomFontStyle().common(
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp,
                  color: AppColors.textBlack),
            ),
          ],
        ),
        actions: [
          Image.asset(
            ImageStrings.settings,
            height: 23.w,
            width: 23.w,
            color: AppColors.textBlack,
          ),
          SizedBox(
            width: 16,
          ),
        ],
      ),
      body: Consumer<DbProvider>(builder: (context, data, _) {
        return data.isLoading == true
            ? Center(
          child: CircularProgressIndicator(),
        )
            : Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              color: AppColors.white,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 15.w, vertical: 13.h),
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColors.lightGreen),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10.w,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${data.surahDetails?.first['arabic_surath_name']}',
                                maxLines: 1,
                                style: CustomFontStyle().common(
                                  color: AppColors.black,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                '${data.surahDetails?.first['ayath_count']} Verses',
                                style: CustomFontStyle().common(
                                  color: AppColors.textBlack,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                            child: CustomButton(
                              borderColor: AppColors.secondaryGreen,
                              bgColor: AppColors.secondaryGreen,
                              text: 'Play Surah',
                              onPress: () {},
                              rightIcon: Expanded(
                                  child: Icon(
                                    Icons.play_arrow_rounded,
                                    color: AppColors.white,
                                  )),
                            )),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Translation Language',
                          style: CustomFontStyle().common(
                            color: AppColors.textBlack.withOpacity(0.6),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        width: 130.w, // Set width of the dropdown
                        height: 50, // Adjust the height as needed
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: DropdownButtonHideUnderline(
                          child: SizedBox(
                            height: 50,
                            child: DropdownButton<String>(
                              value: data.selectedLanguage,
                              onChanged: (String? newValue) {
                                data.switchLanguage(
                                    value: newValue,
                                    id: widget.surathId!);
                              },
                              items: <String>['English', 'malayalam']
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: SizedBox(
                                        width: double
                                            .infinity, // Ensures full width
                                        child: Text(
                                          value,
                                          style: CustomFontStyle().common(
                                            color: AppColors.textBlack,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600,
                                          ), // Adjust text size
                                        ),
                                      ),
                                    );
                                  }).toList(),
                              isExpanded:
                              true, // Ensures dropdown expands within container
                              dropdownColor: Colors
                                  .white, // Adjust dropdown color if needed
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Consumer<QuranProvider>(
                        builder: (context, data, _) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: TranslationSwitch(
                                    switchOnOff: data.showTransliteration!,
                                    onTap: (va) {
                                      data.switchOptions(value: va);
                                    },
                                  )),
                              TranslationSwitch(
                                title: 'Translation',
                                switchOnOff: data.showTranslation!,
                                onTap: (va) {
                                  data.switchOptions(
                                      value: va, isTranslation: false);
                                },
                              )
                            ],
                          );
                        }),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                  controller: _scrollController,
                  padding: EdgeInsets.all(16),
                  itemBuilder: (context, index) {
                    return AyatTile(
                      ayath: data.surahDetails![index],
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(
                    height: 10,
                  ),
                  itemCount: data.surahDetails?.length ?? 0),
            )
          ],
        );
      }),
    );
  }
}