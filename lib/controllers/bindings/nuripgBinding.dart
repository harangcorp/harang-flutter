import 'package:get/get.dart';
import 'package:harang/controllers/nuripgController.dart';

class NuripgBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<NuripgController>(NuripgController(), permanent: true);
  }
}
