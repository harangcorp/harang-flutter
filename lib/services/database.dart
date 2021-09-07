import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:harang/models/ranking.dart';
import 'package:harang/models/user.dart';

class Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> createNewUser(UserModel user) async {
    try {
      await _firestore.collection("users").doc(user.id).set({
        "name": user.name,
        "email": user.email,
        "score": user.score,
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<UserModel> getUser(String? uid) async {
    try {
      DocumentSnapshot _doc =
          await _firestore.collection("users").doc(uid).get();
      return UserModel?.fromDocumentSnapshot(documentSnapshot: _doc);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<List<RankingModel>> getRanking(int count) async {
    List<RankingModel> _ranking = List.empty(growable: true);
    try {
      print("hi");
      await _firestore.collection("users").orderBy("score", descending: true).limit(count).get().then((value){
        value.docs.forEach((element) {
          _ranking.add(RankingModel.fromDocumentSnapshot(documentSnapshot: element));
        });
      });
      print(_ranking);
      return _ranking;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
