import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:harang/controllers/nuripgController.dart';
import 'package:harang/controllers/nuristudyController.dart';

class NuriStudyBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<NuriStudyController>(NuriStudyController(), permanent: true);

    Get.lazyPut<NuripgController>(() => NuripgController());
    Get.lazyPut(() => Dio());
  }
}
