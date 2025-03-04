class JuzhData {
  final int juzhNo;
  final List<SurahData> surahs;

  JuzhData({required this.juzhNo, required this.surahs});
}

class SurahData {
  final String surahName;
  final int startAyah;
  final int endAyah;
  final int verseCount;

  SurahData({required this.surahName, required this.startAyah, required this.endAyah, required this.verseCount});
}