import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/bindings/authBinding.dart';

import 'controllers/notification_controller.dart';
import 'themes/harang_theme.dart';
import 'utils/root.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    NotificationController _notiController = Get.put<NotificationController>(NotificationController(), permanent: true);
    _notiController.initialize();

    return GetMaterialApp(
      theme: harang_theme,
        builder: (context, child) => Scaffold(
              // 화면 클릭 시, 키보드 숨기기
              body: GestureDetector(
                onTap: () {
                  hideKeyboard(context);
                },
                child: child,
              ),
            ),
        initialBinding: AuthBinding(),
        home: Root());
  }

  void hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}
