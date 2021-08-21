import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harang/themes/color_theme.dart';
import 'package:harang/themes/text_theme.dart';

// 명예의 전당 페이지
class Ranking extends StatefulWidget {
  const Ranking({Key? key}) : super(key: key);

  @override
  _RankingState createState() => _RankingState();
}

class _RankingState extends State<Ranking> {
  List<Map> dummyData = [
    {"name": "내이름은유채영", "pointAmount": 1922, "profileImage": "logo.png"},
    {"name": "안종현", "pointAmount": 1916, "profileImage": "logo.png"},
    {"name": "라도희입니다", "pointAmount": 1525, "profileImage": "logo.png"},
    {"name": "김밥은가는비단", "pointAmount": 1417, "profileImage": "logo.png"},
    {"name": "네오와빨간호박", "pointAmount": 1400, "profileImage": "logo.png"},
    {"name": "로건의고운쌈", "pointAmount": 1301, "profileImage": "logo.png"},
    {"name": "둥근단팥", "pointAmount": 1212, "profileImage": "logo.png"},
    {"name": "네모난땅콩", "pointAmount": 1098, "profileImage": "logo.png"},
    {"name": "세모난호두", "pointAmount": 1045, "profileImage": "logo.png"},
    {"name": "윤지의지팡이", "pointAmount": 903, "profileImage": "logo.png"},
  ];

  Map dummyProfile = {
    "name": "더미닉네임123",
    "profileImage": "logo.png",
    "rank": 916,
    "levelStage": 10,
    "levelDetailStage": 3,
    "point": 225
  };

  final Future<void> Function() onRefresh = () async => print('refresh!');

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xffF9E6FC),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          title(),
          userInfo(_height, _width),
          Hero(

            tag: "ranking",
            child: Column(    crossAxisAlignment: CrossAxisAlignment.start,children: [Container(
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.7),border: Border.all(color: Colors.white, width: 1),borderRadius: BorderRadius.circular(20)
              ),
              child: Column(children: [Text("사용자 랭킹"),],),
              width: _width * 0.89,
              height: _height * 0.55,
            )],),
          ),

        ],
      ),
    );
  }


  SizedBox userInfo(double _height, double _width) {
    return SizedBox(
      width: _width,
      height: _height * 0.2,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xffEDB1F1),
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                children: [
                  Stack(
                    children: [
                      Container(
                        color: Colors.white,
                        width: 30,
                        height: 30,
                      ),
                      Container(
                        color: Colors.red,
                        width: 10,
                        height: 10,

                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text("닉네임을 정하자"),
                      Row(
                        children: [
                          Container(
                            child: Text("단계"),
                          ),
                          Container(
                            child: Text("포인트"),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
              height: _height * 0.16,
              width: _width * 0.89,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.white.withOpacity(0.7),
                  border: Border.all(color: Colors.white, width: 1)
              ),
              height: _height * 0.07,
              width: _width * 0.69,
            ),
          )
        ],
      ),
    );
  }

  Stack title() {
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          child: Container(
            height: 9,
            width: 140,
            color: Color(0xffEDB1F1),
          ),
        ),
        Text(
          "나의 학습방",
          style: np_title,
        ),
      ],
    );
  }

  CustomScrollView buildCustomScrollView(double _height, double _width) {
    return CustomScrollView(
      physics:
      const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      slivers: <Widget>[
        SliverPersistentHeader(
          pinned: true,
          floating: false,
          delegate: Delegate("명예의 전당", _height),
        ),
        SliverAppBar(
          pinned: false,
          snap: true,
          floating: true,
          automaticallyImplyLeading: false,
          expandedHeight: _height * 0.26,
          flexibleSpace: FlexibleSpaceBar(
            background: MyProfileBox(
                dummyProfile["name"],
                dummyProfile["profileImage"],
                dummyProfile["rank"],
                dummyProfile["levelStage"],
                dummyProfile["levelDetailStage"],
                dummyProfile["point"]),
          ),
        ),
        CupertinoSliverRefreshControl(
          refreshTriggerPullDistance: 100.0,
          refreshIndicatorExtent: 3.0,
          onRefresh: onRefresh,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
                (c, i) => Stack(
              children: [
                SizedBox(
                  height: _height * 0.105,
                  width: _width,
                  child: Container(
                    color: Colors.white,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    getBlankBox(i),
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
                          width: 130,
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
                    SizedBox(
                      height: _height * 0.0225,
                    )
                  ],
                ),
              ],
            ),
            childCount: dummyData.length,
          ),
        ),
      ],
    );
  }

  SizedBox getBlankBox(int index) {
    //1등의 리스트박스가 위로 올라가 있어 그림자가 제대로 표시되지 않는 현상을 해결하기 위한 Method
    SizedBox result = SizedBox();

    if (index == 0) {
      result = SizedBox(
        height: 3,
      );
    }

    return result;
  }

  SizedBox getRankPlayerPrize(int index) {
    SizedBox result = SizedBox();

    if (index < 3) {
      String medalIconPath = "assets/images/goldMedal.png";
      if (index == 1) {
        medalIconPath = "assets/images/silverMedal.png";
      } else if (index == 2) {
        medalIconPath = "assets/images/bronzeMedal.png";
      }

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
    if (index < 3) {
      shadowColor = medalColor;
      containerSize = 50;
    }

    Stack result = Stack(
      children: [
        Row(
          children: [
            SizedBox(
              width: (50 - containerSize) / 2,
            ),
            Container(
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

  Text getRankText(int index, String textKind) {
    //textKind: name, point, rank
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

class Delegate extends SliverPersistentHeaderDelegate {
  final Color backgroundColor = Colors.white;
  final String _title;
  final double _height;

  Delegate(this._title, this._height);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: backgroundColor,
      child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: _height * 0.065,
              ),
              Stack(children: [
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: 10,
                    width: 220,
                    color: hallOfFame,
                  ),
                ),
                Text(
                  _title,
                  style: homeTitleStyle,
                ),
              ]),
            ],
          )),
    );
  }

  @override
  double get maxExtent => 125;

  @override
  double get minExtent => 125;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class MyProfileBox extends StatelessWidget {
  final String _name, _profileImage;
  final int _rank, _levelStage, _levelDetailStage, _point;

  MyProfileBox(this._name, this._profileImage, this._rank, this._levelStage,
      this._levelDetailStage, this._point);

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
        body: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: _height,
                width: _width,
                child: Container(
                  color: Colors.white,
                ),
              ),
              Container(
                height: _height * 0.17,
                width: _width * 0.87,
                alignment: Alignment.topCenter,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: hallOfFame,
                    blurRadius: 7,
                  )
                ], color: hallOfFame, borderRadius: BorderRadius.circular(30)),
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
                              Container(
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
                                    "assets/images/" + _profileImage,
                                    width: 45,
                                    height: 45,
                                  )),
                              Positioned(
                                left: 48,
                                child: Container(
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
                                child: Container(
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
                                  _levelStage.toString(),
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
                                _name,
                                style: hallOfFame_BoxTitleStyle,
                              ),
                              SizedBox(
                                height: _height * 0.012,
                              ),
                              Row(
                                children: [
                                  Container(
                                    //최종 레벨
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
                                          child: Container(
                                            width: 17,
                                            height: 17,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(30),
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
                                            )),
                                        Positioned(
                                          top: 3.3,
                                          left: (_width * 0.08) -
                                              (_levelStage.toString().length * 2) +
                                              (_levelDetailStage.toString().length *
                                                  2),
                                          child: Text(
                                            "Lv. " +
                                                _levelStage.toString() +
                                                "-" +
                                                _levelDetailStage.toString(),
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
                                  Container(
                                    //포인트
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
                                          child: Container(
                                            width: 17,
                                            height: 17,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(30),
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
                                            )),
                                        Positioned(
                                          top: 3.3,
                                          left: (_width * 0.11) -
                                              (_point.toString().length * 2),
                                          child: Text(
                                            _point.toString(),
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
                        ]),
                    SizedBox(
                      height: _height * 0.02,
                    ),
                  ],
                ),
              ),
              Positioned(
                top: _height * 0.195,
                left: _width * 0.145,
                child: Container(
                  width: _width * 0.7,
                  height: _height * 0.073,
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: hallOfFame,
                      blurRadius: 15,
                    )
                  ], color: Colors.white, borderRadius: BorderRadius.circular(30)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _rank.toString() + "위",
                        style: hallOfFame_subBoxRankStyle,
                      ),
                      SizedBox(
                        width: _width * 0.025,
                      ),
                      Stack(
                        children: [
                          Container(
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
                        _name,
                        style: hallOfFame_subBoxNameStyle,
                      ),
                      SizedBox(
                        width: _width * 0.03,
                      ),
                      Text(
                        _point.toString(),
                        style: hallOfFame_subBoxPointStyle,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
