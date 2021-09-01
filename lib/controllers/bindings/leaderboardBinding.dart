import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:harang/controllers/nuripgController.dart';

import '../leaderboardController.dart';

class LeaderboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LeaderBoardController>(() => LeaderBoardController());
  }
}
