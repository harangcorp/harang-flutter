import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harang/controllers/authController.dart';
import 'package:harang/controllers/userController.dart';
import 'package:harang/screens/home.dart';
import 'package:harang/screens/auth/login.dart';
import 'package:harang/screens/auth/splash.dart';

class Root extends GetWidget<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        Get.put<UserController>(UserController());
        if (Get.find<AuthController>().user?.uid != null) {
          return Home();
        } else {
          return Splash();
        }
      },
    );
  }
}
