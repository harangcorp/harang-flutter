import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              title(),
              AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                  child: controller.isSelected.value
                      ? Container(
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.7),
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0xffEDB1F1).withOpacity(0.5),
                                    offset: Offset(-4, 4),
                                    blurRadius: 20)
                              ]),
                          height: height * 0.07,
                          width: width * 0.69,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "916위",
                                style: TextStyle(
                                    color: Color(0xffCF50D8),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17),
                              ),
                              CircleAvatar(),
                              Text(
                                "${controller.name}",
                                style: TextStyle(
                                    fontFamily: 'NotoSans',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: black),
                              ),

                              Text("${controller.score}",
                                  style: TextStyle(
                                      color: black,
                                      fontFamily: 'GmarketSans',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15))
                            ],
                          ),
                        )
                      : userBox(width, height)),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 1),
                  child: controller.isSelected.value
                      ? Container()
                      : Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "학습 진행률",
                                style: leaderBoard_subtitle,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                decoration: buildBoxDecoration(),
                                width: width * 0.43,
                                height: width * 0.43,
                              )
                            ],
                          ),
                        ),
                ),
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                  child: controller.isSelected.value
                      ? Container(
                          decoration: buildBoxDecoration(),
                          width: width * 0.86,
                          height: height * 0.6,
                    child: GestureDetector(onTap: ()=>controller.isSelected.value = false, child: Icon(Icons.close)),
                        )
                      : Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("사용자 랭킹", style: leaderBoard_subtitle),
                              SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () => controller.isSelected.value =
                                    !controller.isSelected.value,
                                child: Container(
                                  decoration: buildBoxDecoration(),
                                  width: width * 0.33,
                                  height: width * 0.43,
                                ),
                              )
                            ],
                          ),
                        ),
                )
              ]),
              AnimatedSwitcher(
                duration: Duration(milliseconds: 500),
                child: controller.isSelected.value
                    ? Container()
                    : Container(
                        child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("이번주 학습량", style: leaderBoard_subtitle),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: buildBoxDecoration(),
                            width: width * 0.84,
                            height: height * 0.23,
                          )
                        ],
                      )),
              )
            ],
          ),
        ));
  }

  BoxDecoration buildBoxDecoration() {
    return BoxDecoration(
        color: Colors.white.withOpacity(0.4),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(0.4),
          width: 1,
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
              Text(
                controller.name.value,
                style: TextStyle(
                    color: Color(0xffCF50D8),
                    fontFamily: 'NotoSans',
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              Row(
                children: [
                  Container(),
                  Container(
                    child: Text(
                      "${controller.score.value}",
                      style: TextStyle(
                          color: Color(0xffCF50D8),
                          fontFamily: 'GmarketSans',
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ),
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
