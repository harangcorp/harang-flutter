import 'package:cloud_firestore/cloud_firestore.dart';

class RankingModel {
  String? name;
  int? score;

  RankingModel({ this.name,  this.score});

  RankingModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    name = documentSnapshot["name"];
    score = documentSnapshot["score"];
  }
}
