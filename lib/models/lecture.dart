import 'package:cloud_firestore/cloud_firestore.dart';

class LectureContent {
  String? chapterColor;
  Map? chapterContent = {};
  int? chapterStageAmount;

  LectureContent({this.chapterColor, this.chapterContent, this.chapterStageAmount});

  LectureContent.fromDocumentSnapshot({required int chapterNum, required DocumentSnapshot documentSnapshot}) {
    chapterColor = documentSnapshot["color"];
    chapterStageAmount = int.parse(documentSnapshot["stageAmount"].toString());

    for (int i=1; i<=chapterStageAmount!; i++) {
      chapterContent![i] = documentSnapshot["$i"];
    }
  }
}
