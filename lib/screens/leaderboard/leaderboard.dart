import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harang/screens/leaderboard/ranking.dart';
import 'package:harang/themes/color_theme.dart';
import 'package:harang/themes/text_theme.dart';

// 명예의 전당 페이지
class LeaderBoard extends StatefulWidget {
  const LeaderBoard({Key? key}) : super(key: key);

  @override
  _LeaderBoardState createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
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
            Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("학습진행률"), Container(
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.8),border: Border.all(color: Colors.white, width: 1),borderRadius: BorderRadius.circular(20)
              ),
              width: 160,
              height: 160,
            )],),
        GestureDetector(
          onTap: ()=>Get.to(Ranking(), transition: Transition.noTransition),
          child: Hero(
            tag: "ranking",

            child: Column(    crossAxisAlignment: CrossAxisAlignment.start,children: [Text("사용자 랭킹"),Container(
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.8),border: Border.all(color: Colors.white, width: 1),borderRadius: BorderRadius.circular(20)
              ),
              width: 123,
              height: 160,
            )],),
          ),
        ),
      ],
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [Text("이번주 학습량"),Container(
        decoration: BoxDecoration(color: Colors.white.withOpacity(0.8),border: Border.all(color: Colors.white, width: 1),borderRadius: BorderRadius.circular(20)
        ),
        width: _width * 0.8,
        height: _height * 0.18,
      )],
            )
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
  }}