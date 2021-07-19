import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harang/controllers/authController.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:harang/controllers/bindings/nuripgBinding.dart';
import 'package:harang/controllers/nuripgController.dart';
import 'package:harang/screens/nuriplayground/nuriplayground.dart';

import 'leaderboard/leaderboard.dart';
import 'study_nuri/study_main.dart';

class Home extends GetWidget<AuthController> {
  Home({Key? key}) : super(key: key);
  final SwiperController swController = SwiperController();
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
              child: Text("로그아웃"), onPressed: () => controller.signOut()),
          Expanded(
            child: Swiper(
              loop: false,
              index: 0,
              scrollDirection: Axis.horizontal,
              controller: swController,
              viewportFraction: 0.8,
              scale: 0.8,
              itemHeight: 100,
              itemWidth: 100,
              itemCount: 3,
              onTap: (index) => Get.to(
                articles[index]["page"],
                binding: NuripgBinding(),
              ),
              itemBuilder: (context, index) => Column(
                children: [
                  textBox(index),
                  Container(
                    height: _height * 0.55,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: articles[index]["color"],
                              blurRadius: 40,
                              offset: Offset(0, 10))
                        ],
                        color: articles[index]["color"],
                        borderRadius: BorderRadius.circular(30)),
                  ),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }

  Column textBox(int? index) {
    return Column(
      children: [
        Container(
          child: Text(
            "${articles[index ?? 0]["title"]}",
          ),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: articles[index ?? 0]["color"]))),
        ),
        Text("${articles[index ?? 0]["content"]}")
      ],
    );
  }
}

final List<Map> articles = [
  {
    "title": "누리 놀이터",
    "content": "상상하고 이뤄라! 누리 놀이터에서!\n멋진 아이디어를 마음껏 펼칠 공간을 소개합니다",
    "color": Color(0xff8EF6E4),
    "page": NuriPlayGround()
  },
  {
    "title": "단계별 학습하기",
    "content": "차근차근 알려드립니다!\n당신도 곧 누리 마스터가 될 거예요",
    "color": Color(0xffD59BF6),
    "page": StudyMain()
  },
  {
    "title": "명예의 전당",
    "content": " 다른 사용자들과 비교하며\n나의 실력을 확인 할 수 있습니다",
    "color": Color(0xffEDB1F1),
    "page": LeaderBoard()
  },
];
