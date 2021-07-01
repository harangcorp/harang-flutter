import 'package:get/get.dart';
import 'package:harang/app/modules/home/home_page.dart';
import 'package:harang/app/modules/login/login_page.dart';
import 'pages.dart';

class AppPages {
  static final pages = [
    GetPage(name: Routes.LOGIN, page: () => LoginPage()),
    GetPage(name: Routes.HOME, page: () => HomePage())
  ];
}