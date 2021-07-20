import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:harang/controllers/nuripgController.dart';

class NuripgBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NuripgController>(() => NuripgController());
    Get.lazyPut(() => Dio());
  }
}
