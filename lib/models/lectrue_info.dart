import 'package:cloud_firestore/cloud_firestore.dart';

class LectureInfo {
  Map<int,Map<int,bool>>? first;
  Map<int,Map<int,bool>>? second;
  Map<int,Map<int,bool>>? third;
  String? requiredStage;

  LectureInfo({this.first, this.second, this.third, this.requiredStage});

  LectureInfo.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    first = documentSnapshot[1];
    second = documentSnapshot[2];
    third = documentSnapshot[3];
    requiredStage = documentSnapshot["requiredStage"];
  }
}
