import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:harang/themes/color_theme.dart';
import 'package:harang/themes/text_theme.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// 명예의 전당 페이지
class LeaderBoard extends StatefulWidget {
  const LeaderBoard({Key? key}) : super(key: key);

  @override
  _LeaderBoardState createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  List<Map> dummyData = [
    { "name": "내이름은유채영", "pointAmount": 1922, "profileImage": "logo.png" },
    { "name": "안종현", "pointAmount": 1916, "profileImage": "logo.png" },
    { "name": "라도희입니다", "pointAmount": 1525, "profileImage": "logo.png" },
    { "name": "김밥은가는비단", "pointAmount": 1417, "profileImage": "logo.png" },
    { "name": "네오와빨간호박", "pointAmount": 1400, "profileImage": "logo.png" },
    { "name": "로건의고운쌈", "pointAmount": 1301, "profileImage": "logo.png" },
    { "name": "둥근단팥", "pointAmount": 1212, "profileImage": "logo.png" },
    { "name": "네모난땅콩", "pointAmount": 1098, "profileImage": "logo.png" },
    { "name": "세모난호두", "pointAmount": 1045, "profileImage": "logo.png" },
    { "name": "윤지의지팡이", "pointAmount": 903, "profileImage": "logo.png" },
  ];

  Map dummyProfile = {
    "name": "더미닉네임123",
    "profileImage": "logo.png",
    "rank": 916,
    "levelStage": 10,
    "levelDetailStage": 3,
    "point": 225
  };

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    //items.add((items.length+1).toString());
    if(mounted)
      setState(() {

      });
    _refreshController.loadComplete();
  }


  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
        body: Center(
            child: Column (
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 10,
                  height: _height * 0.07,
                ),
                Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        child: Container(
                          height: 10,
                          width: 220,
                          color: hallOfFame,
                        ),
                      ),
                      Text(
                        "명예의 전당",
                        style: homeTitleStyle,
                      ),
                    ]
                ),
                SizedBox(
                  width: 10,
                  height: _height * 0.07,
                ),
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    SizedBox(
                      height: _height * 0.24,
                      width: _width * 0.9,
                    ),
                    Container(
                      height: _height * 0.17,
                      width: _width * 0.87,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: hallOfFame,
                              blurRadius: 7,
                            )
                          ],
                          color: hallOfFame,
                          borderRadius: BorderRadius.circular(30)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Stack(
                                  children: [
                                    SizedBox(
                                      width: _width * 0.187,
                                      height: _height * 0.05,
                                    ),
                                    Container (
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Positioned(
                                      top: 5,
                                      left: 8,
                                      child: Image.asset(
                                        "assets/images/" + dummyProfile["profileImage"],
                                        width: 45,
                                        height: 45,
                                      )
                                    ),
                                    Positioned(
                                      left: 48,
                                      child: Container (
                                        width: 18,
                                        height: 18,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 2.7,
                                      left: 50.5,
                                      child: Container (
                                        width: 13,
                                        height: 13,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: hallOfFame,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 5,
                                      left: 52,
                                      child: Text(
                                        dummyProfile["levelStage"].toString(),
                                        style: hallOfFame_BoxProfileImagePointStyle,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: _width * 0.08,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      dummyProfile["name"],
                                      style: hallOfFame_BoxTitleStyle,
                                    ),
                                    SizedBox(
                                      height: _height * 0.012,
                                    ),
                                    Row(
                                      children: [
                                        Container ( //최종 레벨
                                          width: _width * 0.23,
                                          height: _height * 0.031,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(30),
                                            color: Colors.white,
                                          ),
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                top: 2,
                                                left: 2.5,
                                                child: Container (
                                                  width: 17,
                                                  height: 17,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(30),
                                                    color: purpleFour,
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                  top: 4.8,
                                                  left: 5.5,
                                                  child: Image.asset(
                                                    "assets/images/level.png",
                                                    width: 10,
                                                    height: 10,
                                                  )
                                              ),
                                              Positioned(
                                                top: 3.3,
                                                left: (_width * 0.09) - ((dummyProfile["levelStage"].toString().length * 2) + (dummyProfile["levelDetailStage"].toString().length * 2)),
                                                child: Text(
                                                  "Lv. " + dummyProfile["levelStage"].toString() + "-" + dummyProfile["levelDetailStage"].toString(),
                                                  textAlign: TextAlign.center,
                                                  style: hallOfFame_BoxDescriptionStyle,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 7,
                                        ),
                                        Container ( //포인트
                                          width: _width * 0.2,
                                          height: _height * 0.031,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(30),
                                            color: Colors.white,
                                          ),
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                top: 2,
                                                left: 2.5,
                                                child: Container (
                                                  width: 17,
                                                  height: 17,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(30),
                                                    color: purpleFour,
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                  top: 4.5,
                                                  left: 4.7,
                                                  child: Image.asset(
                                                    "assets/images/coin.png",
                                                    width: 11,
                                                    height: 11,
                                                  )
                                              ),
                                              Positioned(
                                                top: 3.3,
                                                left: (_width * 0.1) - (dummyProfile["point"].toString().length * 2),
                                                child: Text(
                                                  dummyProfile["point"].toString(),
                                                  textAlign: TextAlign.center,
                                                  style: hallOfFame_BoxDescriptionStyle,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: _height * 0.02,
                                    )
                                  ],
                                )
                              ]
                          ),
                          SizedBox(
                            height: _height * 0.02,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: _height * 0.14,
                      left:  _width * 0.1,
                      child: Container(
                        width: _width * 0.7,
                        height: _height * 0.073,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: hallOfFame,
                                  blurRadius: 15,
                                  )
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              dummyProfile["rank"].toString() + "위",
                              style: hallOfFame_subBoxRankStyle,
                            ),
                            SizedBox(
                              width: _width * 0.025,
                            ),
                            Stack(
                              children: [
                                Container (
                                  width: _width * 0.085,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    border: Border.all(
                                      width: 2,
                                      color: hallOfFame,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: _height * 0.02,
                                  left: _width * 0.013,
                                  child: Image.asset(
                                    "assets/images/logo.png",
                                    width: _width * 0.06,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: _width * 0.02,
                            ),
                            Text(
                              dummyProfile["name"],
                              style: hallOfFame_subBoxNameStyle,
                            ),
                            SizedBox(
                              width: _width * 0.03,
                            ),
                            Text(
                              dummyProfile["point"].toString(),
                              style: hallOfFame_subBoxPointStyle,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  height: _height * 0.558,
                  width: _width * 0.95,
                  child: SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: true,
                    physics: BouncingScrollPhysics(),
                    header: ClassicHeader(),
                    footer: CustomFooter(
                      builder: (context, mode){
                        Widget body ;
                        if(mode==LoadStatus.idle){
                          body =  Text("밀어올려 로딩하기");
                        }
                        else if(mode==LoadStatus.loading){
                          body =  CupertinoActivityIndicator();
                        }
                        else if(mode == LoadStatus.failed){
                          body = Text("로딩 실패, 다시시도하세요");
                        }
                        else if(mode == LoadStatus.canLoading){
                          body = Icon(Icons.arrow_upward_rounded);
                        }
                        else{
                          body = Text("더 이상의 데이터가 없습니다.");
                        }
                        return Container(
                          height: 55.0,
                          child: Center(child:body),
                        );
                      },
                    ),
                    controller: _refreshController,
                    onRefresh: _onRefresh,
                    onLoading: _onLoading,
                    child: ListView.builder(
                      itemBuilder: (c, i) =>
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 60,
                                child: getRankPlayerPrize(i),
                              ),
                              SizedBox(
                                width: 50,
                                child: getRankPlayerIcon(i),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                width: 120,
                                child: getRankText(i, "name"),
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              SizedBox(
                                width: 45,
                                child: getRankText(i, "point"),
                              ),
                            ],
                          ),
                      itemExtent: 100.0,
                      itemCount: dummyData.length,
                    ),
                  ),
                )
              ],
            )
        )
    );
  }

  SizedBox getRankPlayerPrize(int index) {
    SizedBox result = SizedBox();

    if (index < 3) {
      String medalIconPath = "assets/images/goldMedal.png";
      if (index == 1) { medalIconPath = "assets/images/silverMedal.png"; } else if (index == 2) { medalIconPath = "assets/images/bronzeMedal.png"; }

      result = SizedBox(
        child: Image.asset(
          medalIconPath,
          width: 38,
          height: 38,
        ),
      );
    } else {
      result = SizedBox(
        child: getRankText(index, "rank"),
      );
    }

    return result;
  }

  Stack getRankPlayerIcon(int index) {
    Color medalColor = defaultMedal;
    Color shadowColor = Color(0xFFFFFF);
    double containerSize = 40;

    switch (index) {
      case 0:
        medalColor = goldMedal;
        break;
      case 1:
        medalColor = silverMedal;
        break;
      case 2:
        medalColor = bronzeMedal;
        break;
    }
    if (index < 3) { shadowColor = medalColor; containerSize = 50; }

    Stack result = Stack(
      children: [
        Row(
          children: [
            SizedBox(
              width: (50 - containerSize) / 2,
            ),
            Container (
              width: containerSize,
              height: containerSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(
                  width: 2,
                  color: medalColor,
                ),
                boxShadow: [
                  BoxShadow(
                    color: shadowColor,
                    blurRadius: 3,
                  )
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 5,
          left: 8 + ((50 - containerSize) / 2),
          child: Image.asset(
            "assets/images/" + dummyData[index]["profileImage"],
            width: containerSize - 15,
            height: containerSize - 15,
          ),
        ),
      ],
    );

    return result;
  }

  Text getRankText(int index, String textKind) { //textKind: name, point, rank
    TextStyle nameTextStyle = hallOfFame_defaultMedalNameStyle;
    TextStyle pointTextStyle = hallOfFame_defaultMedalPointStyle;
    TextStyle rankTextStyle = hallOfFame_defaultMedalRankStyle;
    TextStyle finalTextStyle = hallOfFame_defaultMedalNameStyle;
    String finalText = "";

    if (index < 3) {
      if (index == 0) {
        nameTextStyle = hallOfFame_goldMedalNameStyle;
        pointTextStyle = hallOfFame_goldMedalPointStyle;
      } else if (index == 1) {
        nameTextStyle = hallOfFame_silverMedalNameStyle;
        pointTextStyle = hallOfFame_silverMedalPointStyle;
      } else if (index == 2) {
        nameTextStyle = hallOfFame_bronzeMedalNameStyle;
        pointTextStyle = hallOfFame_bronzeMedalPointStyle;
      }
    }

    switch (textKind) {
      case "name":
        finalTextStyle = nameTextStyle;
        finalText = dummyData[index]["name"];
        break;
      case "point":
        finalTextStyle = pointTextStyle;
        finalText = (dummyData[index]["pointAmount"]).toString();
        break;
      case "rank":
        finalTextStyle = rankTextStyle;
        finalText = (index + 1).toString() + "위";
        break;
    }

    Text result = Text(
      finalText,
      style: finalTextStyle,
      textAlign: TextAlign.center,
    );

    return result;
  }

}
