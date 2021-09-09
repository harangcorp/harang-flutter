import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:harang/models/ranking.dart';
import 'package:harang/models/user.dart';
import 'package:harang/services/database.dart';
import 'package:app_usage/app_usage.dart';
import 'package:harang/services/usage_app.dart';
import 'userController.dart';
class LeaderBoardController extends GetxController {
  // List<Map> dummyData = [
  //   {"name": "내이름은유채영", "pointAmount": 1922, "profileImage": "logo.png"},
  //   {"name": "안종현", "pointAmount": 1916, "profileImage": "logo.png"},
  //   {"name": "라도희입니다", "pointAmount": 1525, "profileImage": "logo.png"},
  //   {"name": "김밥은가는비단", "pointAmount": 1417, "profileImage": "logo.png"},
  //   {"name": "네오와빨간호박", "pointAmount": 1400, "profileImage": "logo.png"},
  //   {"name": "로건의고운쌈", "pointAmount": 1301, "profileImage": "logo.png"},
  //   {"name": "둥근단팥", "pointAmount": 1212, "profileImage": "logo.png"},
  //   {"name": "네모난땅콩", "pointAmount": 1098, "profileImage": "logo.png"},
  //   {"name": "세모난호두", "pointAmount": 1045, "profileImage": "logo.png"},
  //   {"name": "윤지의지팡이", "pointAmount": 903, "profileImage": "logo.png"},
  // ];
  //
  // Map dummyProfile = {
  //   "name": "더미닉네임123",
  //   "profileImage": "logo.png",
  //   "rank": 916,
  //   "levelStage": 10,
  //   "levelDetailStage": 3,
  //   "point": 225
  // };
  final isSelected = false.obs;
  late UserModel _user;
  final level = '10';
  Rx<int> score = 0.obs;
  Rx<String> name = ''.obs;
  RxList<RankingModel> rankingData = RxList.empty(growable: true);
  Rx<int> progess_percent = 0.obs;
  
  String profile_image = 'assets/images/login_man.png';
  List<int> usage_time = [0,0,0,0,0,0,0].obs;
  @override
  onInit() async {
    //TODO 데이터 가져오기
    _user = await Database().getUser(FirebaseAuth.instance.currentUser?.uid);
    score.value = _user.score ?? 0;
    name.value = _user.name ?? "이름 없음";
    usage_time =(await UsageApp().getUsageStats());
    print(usage_time);
    // 랭킹 데이터
    rankingData(await Database().getRanking(6));
    print(rankingData.value);


    print(name.value);
    print(FirebaseAuth.instance.currentUser?.email);
  }
}
