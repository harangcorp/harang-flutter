import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harang/app.dart';
import 'server.dart';
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
