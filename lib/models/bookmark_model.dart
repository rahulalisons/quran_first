class SurahBookmarks {
  final int surahNo;
  final String surahName;
  final int bookmarkCount;
   List<Bookmark> bookmarks;

  SurahBookmarks({
    required this.surahNo,
    required this.surahName,
    required this.bookmarkCount,
    required this.bookmarks,
  });
}

class Bookmark {
  final int ayahNo;
  final String ayah;
  final String? translation1;
  final String? translation3;
  final bool isBookmarked;

  Bookmark({
    required this.ayahNo,
    required this.ayah,
    this.translation1,
    this.translation3,
    required this.isBookmarked,
  });

  factory Bookmark.fromMap(Map<String, dynamic> map) {
    return Bookmark(
      ayahNo: map['ayath_no'],
      ayah: map['ayath'],
      translation1: map['en_ayath_t1'],
      translation3: map['en_ayath_t3'],
      isBookmarked: map['isBookmarked'] == 1,
    );
  }
}
