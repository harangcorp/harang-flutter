import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:harang/controllers/authController.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:harang/controllers/bindings/nuripgBinding.dart';
import 'package:harang/controllers/nuripgController.dart';
import 'package:harang/screens/nuriplayground/nuriplayground.dart';
import 'package:harang/themes/text_theme.dart';

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
        crossAxisAlignment: CrossAxisAlignment.center,
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
                  SizedBox(
                    height: _height * 0.05,
                  ),
                  textBox(index, _height),
                  SizedBox(
                    height: _height * 0.10,
                  ),
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
                    child: Stack(
                      children: [
                        Positioned(
                            child: Image.asset(
                          'assets/images/homepage_circle.png',
                          height: 170,
                        )),
                        Positioned(
                            top: _height * 0.43,
                            right: _width * 0.03,
                            child: Image.asset(
                              articles[index]["buttonImage"],
                              height: 80,
                            )),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: _height * 0.05,
                              ),
                              Text(
                                articles[index]["content"],
                                style: articles[index]["content_textStyle"],
                                textAlign: TextAlign.center,
                              ),
                              Image.asset(
                                articles[index]["image"],
                                height: 270,
                                width: 300,
                              ),
                            ]),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }

  Column textBox(int? index, double _height) {
    return Column(
      children: [
        Center(
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                child: Container(
                  height: 10,
                  width: 220,
                  color: articles[index ?? 0]["color"],
                ),
              ),
              Text(
                "${articles[index ?? 0]["title"]}",
                style: homeTitleStyle,
              ),
            ],
          ),
        ),
        SizedBox(
          height: _height * 0.03,
        ),
        Text(
          "${articles[index ?? 0]["description"]}",
          style: homeDescriptionStyle,
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}

final List<Map> articles = [
  {
    "title": "누리 놀이터",
    "description": "상상하고 이뤄라! 누리 놀이터에서!\n멋진 아이디어를 마음껏 펼칠 공간을 소개합니다.",
    "content": "누리를 사용해 무엇을\n만들어 볼까요?",
    "content_textStyle": homeContentStyle_nuriPlayground,
    "color": Color(0xff8EF6E4),
    "buttonImage": "assets/images/nuri_playground_home_button.png",
    "image": "assets/images/nuri_playground.png",
    "page": NuriPlayGround()
  },
  {
    "title": "단계별 학습하기",
    "description": "차근차근 알려드립니다!\n당신도 곧 누리 마스터가 될 거예요 :)",
    "content": "단계별로 배우기 때문에\n부담없이 공부할 수 있어요!",
    "content_textStyle": homeContentStyle_stepbystepStudy,
    "color": Color(0xffD59BF6),
    "buttonImage": "assets/images/stepbystep_study_home_button.png",
    "image": "assets/images/stepbystep_study.png",
    "page": StudyMain()
  },
  {
    "title": "명예의 전당",
    "description": " 다른 사용자들과 비교하며\n나의 실력을 확인 할 수 있습니다!",
    "content": "명예의 전당, 당신을 위한 자리\n높이 날아봐요!",
    "content_textStyle": homeContentStyle_hallOfFame,
    "color": Color(0xffEDB1F1),
    "buttonImage": "assets/images/hall_of_fame_home_button.png",
    "image": "assets/images/hall_of_fame.png",
    "page": LeaderBoard()
  },
];
