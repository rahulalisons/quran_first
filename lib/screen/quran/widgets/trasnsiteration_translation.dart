import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controller/quran_provider.dart';
import 'package:quran_first/screen/quran/widgets/translation_switch.dart';

class TransliterationTranslation extends StatelessWidget {
  final bool isFromSettings;
  const TransliterationTranslation({super.key, this.isFromSettings = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Consumer<QuranProvider>(
        builder: (context, data, _) {
          Widget translationSwitch(
              {String title = 'Transliteration',
              required bool switchOnOff,
              required Function(bool) onTap}) {
            return TranslationSwitch(
              isFomSettings: isFromSettings,
              title: title,
              switchOnOff: switchOnOff,
              onTap: onTap,
            );
          }
          return isFromSettings
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      translationSwitch(
                        switchOnOff: data.showTransliteration!,
                        onTap: (va) => data.switchOptions(value: va),
                      ),
                      const SizedBox(height: 10),
                      translationSwitch(
                        title: 'Translation',
                        switchOnOff: data.showTranslation!,
                        onTap: (va) =>
                            data.switchOptions(value: va, isTranslation: false),
                      ),
                    ],
                  ),
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: translationSwitch(
                        switchOnOff: data.showTransliteration!,
                        onTap: (va) => data.switchOptions(value: va),
                      ),
                    ),
                    const SizedBox(width: 10),
                    translationSwitch(
                      title: 'Translation',
                      switchOnOff: data.showTranslation!,
                      onTap: (va) =>
                          data.switchOptions(value: va, isTranslation: false),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
