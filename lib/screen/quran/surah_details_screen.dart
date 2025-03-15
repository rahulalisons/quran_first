import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:quran_first/controller/quran_provider.dart';
import 'package:quran_first/core/values/colors.dart';
import 'package:quran_first/core/values/strings.dart';
import 'package:quran_first/screen/common_widgets/custom_button.dart';
import 'package:quran_first/screen/quran/widgets/ayat_tile.dart';
import 'package:quran_first/screen/quran/widgets/ayath_index_list.dart';
import 'package:quran_first/screen/quran/widgets/text_settings.dart';
import 'package:quran_first/screen/quran/widgets/translation_change.dart';
import 'package:quran_first/screen/quran/widgets/translation_switch.dart';
import 'package:quran_first/screen/quran/widgets/trasnsiteration_translation.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../controller/db_provider.dart';
import '../../core/utils/helper/bottomsheet_util.dart';
import '../../models/translator_model.dart';
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
  AutoScrollController? controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    var provider = Provider.of<DbProvider>(context, listen: false);

    provider.selectedTranslator =
        Translator(id: 1, name: 'Shakir', language: "English");
    await provider.getSurahDetail(widget.surathId!);
    controller = AutoScrollController(
        viewportBoundaryGetter: () =>
            Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        axis: Axis.vertical);
    context.read<DbProvider>().fetchTranslator();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(milliseconds: 500), () {
        if (widget.ayathNumber != null && widget.ayathNumber! > 0) {
          _scrollToAyath(widget.ayathNumber!);
        } else {
          _scrollToAyath(0);
        }
      });
    });
  }

  Future _scrollToAyath(int ayahIndex) async {
    await controller!
        .scrollToIndex(ayahIndex - 1, preferPosition: AutoScrollPosition.begin);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGray,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.transparent,
        title: InkWell(
          onTap: () {
            switchAya(
              onAyaSelected: (index) {
                _scrollToAyath(index);
              },
              context: context,
              name: widget.surah['en_surath_name'],
            );
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${widget.surah['surath_no']}. ${widget.surah['en_surath_name']} ',
                style: CustomFontStyle().common(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                    color: AppColors.textBlack),
              ),
              Icon(Icons.arrow_drop_down)
            ],
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              bottomSheet(
                  isDismissible: true,
                  enableDrag: false,
                  context: context,
                  content: SizedBox(
                    width: ScreenUtil().screenWidth,
                    child: TextSettings(),
                  ));
            },
            child: Image.asset(
              ImageStrings.settings,
              height: 23.w,
              width: 23.w,
              color: AppColors.textBlack,
            ),
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
                                onPress: () async {},
                                rightIcon: Expanded(
                                    child: Icon(
                                  Icons.play_arrow_rounded,
                                  color: AppColors.white,
                                )),
                              )),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                              InkWell(
                                onTap: () {
                                  changeTraslation(
                                      selectedTranslator:
                                          data.selectedTranslator,
                                      context: context,
                                      translator: data.translator,
                                      onTap: (va) {
                                        data.selectTranslator(
                                            value: va,
                                            surathId: widget.surathId);
                                      });
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      '${data.selectedTranslator?.language} ',
                                      overflow: TextOverflow.fade,
                                      maxLines: 1,
                                      style: CustomFontStyle().common(
                                        color: AppColors.textBlack,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Icon(Icons.arrow_drop_down)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        TransliterationTranslation()
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                        controller: controller,
                        padding: EdgeInsets.all(16),
                        itemBuilder: (context, index) {
                          return AutoScrollTag(
                            key: ValueKey(index),
                            controller: controller!,
                            index: index,
                            child: AyatTile(
                              ayath: data.surahDetails![index],
                            ),
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
