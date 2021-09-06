import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String? name;
  String? email;
  int? score;
  Map? stageProgress;

  UserModel({this.id, this.name, this.email, this.score, this.stageProgress});

  UserModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    id = documentSnapshot.id;
    name = documentSnapshot["name"];
    email = documentSnapshot["email"];
    score = documentSnapshot["score"];
    stageProgress = documentSnapshot["stageProgress"];
  }
}
