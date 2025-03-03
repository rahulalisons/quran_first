// import 'package:flutter/material.dart';
// import '../db_helper/db_helper.dart';
//
// class ChapterListScreen extends StatelessWidget {
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Quran Chapters'),
//       ),
//       body: FutureBuilder<List<Map<String, dynamic>>>(
//         future: fetchChapters(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return const Center(child: Text('No chapters found.'));
//           } else {
//             final chapters = snapshot.data!;
//             return ListView.builder(
//               itemCount: chapters.length,
//               itemBuilder: (context, index) {
//                 final chapter = chapters[index];
//                 return ListTile(
//                   title: Text('${chapter['surath_name']}'),
//                   subtitle: Text(
//                       'Chapter ${chapter['id']} - ${chapter['verses_count']} verses'),
//                   onTap: () {
//                     // You can navigate to a SurahScreen here (if you have one) to show verses for the tapped chapter
//                     // Example:
//                     // Navigator.push(context, MaterialPageRoute(builder: (context) => SurahScreen(suraNumber: chapter['id'])));
//                   },
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }
