import 'package:app_usage/app_usage.dart';

//TODO: 데이터 가져오기 

class UsageApp {
  List<int> _info = [0,0,0,0,0,0,0];
  Future<List<int>> getUsageStats() async {
    try {
      DateTime nowDate = new DateTime.now();
      DateTime endDate = new DateTime.now();
      DateTime startDate = new DateTime(nowDate.year, nowDate.month,nowDate.day);
      print("startDate ${startDate.toString()}");
      print("endDate ${endDate.toString()}");

      for (var i = 0; i < DateTime.now().weekday; i++) {
        print("i = ${i} start = ${startDate.toString()} , end = ${endDate.toString()}");
        List<AppUsageInfo> infoList =
        await AppUsage.getAppUsage(startDate, endDate);
        endDate = startDate.subtract(Duration(microseconds: 1));
        startDate = startDate.subtract(Duration(days: 1));
        for (var info in infoList) {
          if (info.appName == 'harang'){
            _info[DateTime.now().weekday - i - 1] = info.usage.inMinutes;
            print(info.usage);
            print(info);
          }
        }
      }
      return _info;
    } on AppUsageException catch (exception) {
      print(exception);
      return [];
    }
  }
}
