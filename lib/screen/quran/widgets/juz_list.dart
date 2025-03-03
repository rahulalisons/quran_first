import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_first/controller/quran_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../../models/JuzSurahItem.dart';

class JuzList extends StatefulWidget {
  @override
  State<JuzList> createState() => _JuzSurahScreenState();
}

class _JuzSurahScreenState extends State<JuzList> {
  @override
  void initState() {
    super.initState();
    Provider.of<QuranProvider>(context, listen: false).fetchJuzSurahData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<JuzSurahItem>?>(
      future: context.read<QuranProvider>().fetchJuzSurahData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No data available'));
        }

        final juzSurahList = snapshot.data!;

        return ListView.builder(
          itemCount: juzSurahList.length,
          itemBuilder: (context, juzIndex) {
            final juz = juzSurahList[juzIndex];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    'Juz ${juz.juzNumber}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Column(
                  children: juz.surahs.map((surah) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 4,
                              spreadRadius: 1,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${surah.surahNumber}. ${surah.surahName}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              'Verse ${surah.startVerse} - ${surah.endVerse}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
