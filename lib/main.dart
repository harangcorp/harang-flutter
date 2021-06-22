import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harang/src/app.dart';
import 'src/controller/api_controller_nuri.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: App(),
    );
  }
}
