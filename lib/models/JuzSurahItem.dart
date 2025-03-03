// Models
class JuzSurahItem {
  final int juzNumber;
  final List<SurahInfo> surahs;

  JuzSurahItem({required this.juzNumber, required this.surahs});
}

class SurahInfo {
  final int surahNumber;
  final String surahName;
  final int startVerse;
  final int endVerse;

  SurahInfo({
    required this.surahNumber,
    required this.surahName,
    required this.startVerse,
    required this.endVerse,
  });
}