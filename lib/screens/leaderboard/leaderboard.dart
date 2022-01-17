import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:harang/controllers/leaderboardController.dart';
import 'package:harang/themes/color_theme.dart';
import 'package:harang/themes/text_theme.dart';
import 'package:harang/widgets/weekly_chart.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'dart:io';

// 명예의 전당 페이지

class LeaderBoard extends GetWidget<LeaderBoardController> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
            Color(0xffF8C0FC),
            Color(0xffF6E1FA),
            Color(0xffF4EBFD),
            Color(0xffEFDEFB),
            Color(0xffEDB1F1)
          ])),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Obx(
            () => SingleChildScrollView(
              child: Container(
                constraints: BoxConstraints(minHeight: height),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    title(width),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      decoration: controller.isSelected.value
                          ? BoxDecoration(
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
                                ])
                          : BoxDecoration(
                              color: hallOfFame,
                              borderRadius: BorderRadius.circular(20),
                              ),
                      height: controller.isSelected.value
                          ? height * 0.07
                          : height * 0.135,
                      width: controller.isSelected.value
                          ? width * 0.69
                          : width * 0.762,
                      child: controller.isSelected.value
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "${controller.playerRank.value}위",
                                  style: TextStyle(
                                      color: Color(0xffCF50D8),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                                CircleAvatar(
                                  radius: 17,
                                  backgroundColor: Color(0xffCF50D8),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 15,
                                    backgroundImage: ExactAssetImage(
                                        controller.profile_image
                                    ),
                                  ),
                                ),
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
                                        color: Color(0xffCF50D8),
                                        fontFamily: 'GmarketSans',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15))
                              ],
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: width * 0.17,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.asset(
                                        controller.profile_image
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                          controller.name.value,
                                          style: hallOfFame_BoxTitleStyle
                                      ),
                                      SizedBox(height: height * 0.016),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container ( //현재 레벨
                                            width: width * 0.23,
                                            height: height * 0.031,
                                            margin: EdgeInsets.only(right: width * 0.025),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(30),
                                              color: Colors.white,
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Container (
                                                  width: width * 0.0475,
                                                  alignment: Alignment.center,
                                                  margin: EdgeInsets.only(left: width * 0.008, right: width * 0.02),
                                                  decoration: BoxDecoration(
                                                    color: purpleFour,
                                                    shape: BoxShape.circle
                                                  ),
                                                  child: Image.asset(
                                                    "assets/images/level.png",
                                                    width: 10,
                                                    height: 10,
                                                  ),
                                                ),
                                                Text(
                                                  "${controller.progress_stage.value} 단계",
                                                  style: hallOfFame_BoxDescriptionStyle,
                                                )
                                              ],
                                            ),
                                          ),
                                          Container ( //포인트
                                            width: width * 0.2,
                                            height: height * 0.031,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(30),
                                              color: Colors.white,
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Container (
                                                    width: width * 0.0475,
                                                    alignment: Alignment.center,
                                                    margin: EdgeInsets.only(left: width * 0.008, right: (width * 0.055) - (controller.score.value.toString().length * 2.4)),
                                                    decoration: BoxDecoration(
                                                        color: purpleFour,
                                                        shape: BoxShape.circle
                                                    ),
                                                    child: SvgPicture.asset(
                                                      "assets/images/studyNuri/endPage_pointStar.svg",
                                                      fit: BoxFit.contain,
                                                      width: width * 0.035,
                                                    )
                                                ),
                                                Text(
                                                  "${controller.score.value}",
                                                  style: hallOfFame_BoxDescriptionStyle,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            )
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        constraints: BoxConstraints(minWidth: width),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (!controller.isSelected.value)
                                      Text(
                                        "학습 진행률",
                                        style: leaderBoard_subtitle,
                                      ),
                                    if (!controller.isSelected.value)
                                      SizedBox(
                                        height: 10,
                                      ),
                                    AnimatedContainer(
                                      duration: Duration(milliseconds: 300),
                                      decoration: buildBoxDecoration(),
                                      width: controller.isSelected.value
                                          ? 0
                                          : width * 0.43,
                                      height: controller.isSelected.value
                                          ? 0
                                          : width * 0.43,
                                      child: CircularPercentIndicator(
                                          radius: width * 0.3,
                                          lineWidth: width * 0.03,
                                          animation: true,
                                          percent: (controller.progess_percent.value / 100),
                                          circularStrokeCap: CircularStrokeCap.round,
                                          backgroundColor: Color(0xffF8C0FC),
                                          progressColor: Color(0xffCF50D8),
                                          center: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                '마스터까지',
                                                style: TextStyle(
                                                  color: Color(0xffCF50D8),
                                                  fontSize: 9,
                                                  fontFamily: 'GmarketSans',
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              SizedBox(height: 3),
                                              Text(
                                                  "${controller.progess_percent}%",
                                                  style: TextStyle(
                                                      color: Color(0xffCF50D8),
                                                      fontSize: 20,
                                                      fontFamily: 'GmarketSans',
                                                      fontWeight: FontWeight.bold
                                                  ),
                                                  textAlign: TextAlign.center
                                              ),
                                              SizedBox(height: 3),
                                            ],
                                          )
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (!controller.isSelected.value)
                                      Text("사용자 랭킹",
                                          style: leaderBoard_subtitle),
                                    if (!controller.isSelected.value)
                                      SizedBox(
                                        height: 10,
                                      ),
                                    GestureDetector(
                                      onTap: () => controller.isSelected.value =
                                          !controller.isSelected.value,
                                      child: AnimatedContainer(
                                          duration: Duration(milliseconds: 300),
                                          decoration: buildBoxDecoration(),
                                          width: controller.isSelected.value
                                              ? width * 0.86
                                              : width * 0.33,
                                          height: controller.isSelected.value
                                              ? height * 0.6
                                              : width * 0.43,
                                          child: controller.isSelected.value
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.all(16),
                                                        child: Stack(
                                                          children: [
                                                            Align(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Text(
                                                                  "사용자 랭킹",
                                                                  style:
                                                                      ranking_large_title,
                                                                )),
                                                            Align(
                                                                alignment: Alignment
                                                                    .centerRight,
                                                                child: Icon(Icons
                                                                    .close_rounded))
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: ListView.builder(
                                                            itemCount: controller
                                                                .rankingListCountNum
                                                                .value,
                                                            itemBuilder: (context,
                                                                    index) =>
                                                                Padding(
                                                                    padding: EdgeInsets.only(
                                                                        right:
                                                                            24,
                                                                        left:
                                                                            24,
                                                                        bottom:
                                                                            32),
                                                                    child: index >=
                                                                            3
                                                                        ? Stack(
                                                                      alignment: Alignment.center,
                                                                      children: [
                                                                        Positioned(
                                                                          left: 0,
                                                                          child: Text(
                                                                            "${index + 1}위",
                                                                            style: ranking_large_number,
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          "${controller.rankingData.value[index].name}",
                                                                          style: ranking_large_name,
                                                                          textAlign: TextAlign.center,
                                                                        ),
                                                                        Positioned(
                                                                          right: 0,
                                                                          child: Text(
                                                                            "${controller.rankingData.value[index].score}",
                                                                            style: ranking_large_score,
                                                                          ),
                                                                        )
                                                                      ],
                                                                    )
                                                                        : Stack(
                                                                            alignment: Alignment.center,
                                                                            children: [
                                                                              SizedBox(height: height * 0.055),
                                                                              Positioned(
                                                                                left: -5,
                                                                                child: Image.asset(
                                                                                  'assets/images/${_rankerImage[index]}',
                                                                                  height: 35,
                                                                                  width: 35,
                                                                                ),
                                                                              ),
                                                                              Text(
                                                                                "${controller.rankingData.value[index].name}",
                                                                                style: _rankingStyle[index],
                                                                                textAlign: TextAlign.center,
                                                                              ),
                                                                              Positioned(
                                                                                right: 0,
                                                                                child: Text(
                                                                                    "${controller.rankingData.value[index].score}",
                                                                                    style: _rankingScoreStyle[index]
                                                                                ),
                                                                              )
                                                                            ],
                                                                          ))),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : ListView.builder(
                                                  itemCount: controller
                                                      .rankingData.length,
                                                  itemBuilder:
                                                      (context, index) =>
                                                          Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 16,
                                                        bottom: 8,
                                                        right: 16),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "${index + 1}",
                                                          style:
                                                              ranking_tiny_number,
                                                        ),
                                                        Expanded(
                                                            child: Center(
                                                                child: Text(
                                                          "${controller.rankingData.value[index].name}",
                                                          style:
                                                              ranking_tiny_name,
                                                        ))),
                                                      ],
                                                    ),
                                                  ),
                                                )),
                                    ),
                                  ],
                                ),
                              ),
                              if (controller.isSelected.value)
                                SizedBox() // 정렬을 위한 요소
                            ]),
                      ),
                    ),
                    Container(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (!controller.isSelected.value)
                          Text("이번주 학습 시간", style: leaderBoard_subtitle),
                        if (!controller.isSelected.value)
                          SizedBox(
                            height: 10,
                          ),
                        AnimatedContainer(
                          padding: EdgeInsets.only(top: 16, bottom: 8),
                          duration: Duration(milliseconds: 300),
                          decoration: buildBoxDecoration(),
                          width: controller.isSelected.value ? 0 : width * 0.84,
                          height:
                              controller.isSelected.value ? 0 : height * 0.23,
                          child: controller.isSelected.value
                              ? null
                              : (Platform.isAndroid ? WeeklyChart() : Center(child: Text("현재 아이폰에서는 학습 시간 \n분석 기능을 제공하지 않습니다.", textAlign: TextAlign.center, style: leaderboard_studyTime_notSupportOnIOS))),
                        )
                      ],
                    )),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  List _rankerImage = ['goldMedal.png', 'silverMedal.png', 'bronzeMedal.png'];
  List<TextStyle> _rankingStyle = [
    ranking_first_name,
    ranking_second_name,
    ranking_third_name
  ];
  List<TextStyle> _rankingScoreStyle = [
    ranking_first_score,
    ranking_second_score,
    ranking_third_score
  ];

  BoxDecoration buildBoxDecoration() {
    return BoxDecoration(
        color: Colors.white.withOpacity(0.6),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(0.4),
          width: 1,
        ));
  }

  Center title(double width) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(width: width),
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
          Positioned(
              left: width * 0.04,
              child: GestureDetector(
                onTap: () => Get.back(),
                child: Icon(
                  Icons.chevron_left,
                  color: Colors.black,
                  size: width * 0.12,
                ),
              )
          )
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double y;
}
