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
    return Consumer<QuranProvider>(
      builder: (context,juzh,_) {
        return ListView.builder(
          itemCount: juzh.juzhDataList?.length??0,
          itemBuilder: (context, index) {
            final juzhData = juzh.juzhDataList![index];
            return ExpansionTile(
              title: Text('Juzh ${juzhData.juzhNo}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              children: juzhData.surahs.map((surah) {
                return ListTile(
                  title: Text('${surah.surahName}'),
                  subtitle: Text('Verses: ${surah.startAyah} - ${surah.endAyah} (Total: ${surah.verseCount})'),
                );
              }).toList(),
            );
          },
        );
      }
    );
  }
}
