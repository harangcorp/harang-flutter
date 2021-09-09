import 'package:app_usage/app_usage.dart';

//TODO: 데이터 가져오기 

class UsageApp {
  List<int> _info = [];
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
        endDate = startDate;
        startDate = startDate.subtract(Duration(days: 1));
        for (var info in infoList) {
          if (info.appName == 'harang') _info.add(info.usage.inMinutes);
          if (info.appName == 'harang') print(info.appName );

        }
      }
      var length = _info.length;
      print(length);
      for(var i=0;i<7-length;i++){
        _info.add(0);
      }
      return _info;
    } on AppUsageException catch (exception) {
      print(exception);
      return [];
    }
  }
}
