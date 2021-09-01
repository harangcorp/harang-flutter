import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harang/controllers/leaderboardController.dart';
import 'package:harang/screens/leaderboard/ranking.dart';
import 'package:harang/themes/color_theme.dart';
import 'package:harang/themes/text_theme.dart';

// 명예의 전당 페이지

class LeaderBoard extends GetWidget<LeaderBoardController> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Color(0xffFAEEFD),
        body: Obx(
          () => Column(
            children: [
              title(),
              userBox(width, height),
              Row(
                children: [Container(), Container()],
              ),
              Container()
            ],
          ),
        ));
  }

  Container userBox(double width, double height) {
    return Container(
      width: width * 0.84,
      height: height * 0.12,
      decoration: BoxDecoration(
        color: Color(0xffEDB1F1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
              ),
            ],
          ),
          Column(
            children: [
              Text(controller.name.value),
              Row(
                children: [
                  Container(),
                  Container(
                    child: Text("${controller.score.value}"),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Center title() {
    return Center(
      child: Stack(
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
      ),
    );
  }
}
