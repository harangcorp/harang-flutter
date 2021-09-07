import 'package:get/get.dart';
import 'package:harang/controllers/nuristudyController.dart';

class NuriStudyBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<NuriStudyController>(NuriStudyController(), permanent: true);
  }
}
