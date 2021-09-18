import 'package:cloud_firestore/cloud_firestore.dart';

class RankingModel {
  String? name;
  int? score;
  String? id;

  RankingModel({this.name,  this.score, this.id});

  RankingModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    name = documentSnapshot["name"];
    score = documentSnapshot["score"];
    id = documentSnapshot.id;
  }
}
