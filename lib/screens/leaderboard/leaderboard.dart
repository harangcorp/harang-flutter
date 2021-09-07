import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:harang/controllers/leaderboardController.dart';
import 'package:harang/screens/leaderboard/ranking.dart';
import 'package:harang/themes/color_theme.dart';
import 'package:harang/themes/text_theme.dart';
import 'package:harang/widgets/weekly_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// 명예의 전당 페이지

class LeaderBoard extends GetWidget<LeaderBoardController> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Color(0xffFAEEFD),
        body: Obx(
          () => SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(minHeight: height),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  title(),
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
                              color: Color(0xffEDB1F1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                      height: controller.isSelected.value
                          ? height * 0.07
                          : height * 0.12,
                      width: controller.isSelected.value
                          ? width * 0.69
                          : width * 0.84,
                      child: AnimatedCrossFade(
                        duration: Duration(milliseconds: 200),
                        crossFadeState: controller.isSelected.value
                            ? CrossFadeState.showFirst
                            : CrossFadeState.showSecond,
                        firstChild: Row(
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
                        secondChild: Row(
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
                      )),
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
                                    child: SfCircularChart(annotations: <
                                        CircularChartAnnotation>[
                                      CircularChartAnnotation(
                                          widget: Container(
                                              child: const Text('62%',
                                                  style: TextStyle(
                                                      color: Color(0xffCF50D8),
                                                      fontSize: 18,
                                                      fontFamily: 'GmarketSans',
                                                      fontWeight:
                                                          FontWeight.bold))))
                                    ], series: <CircularSeries>[
                                      DoughnutSeries<ChartData, String>(
                                        dataSource: [
                                          ChartData('Others', 52 )
                                        ],
                                        xValueMapper: (ChartData data, _) =>
                                            data.x,
                                        yValueMapper: (ChartData data, _) =>
                                            data.y,
                                        strokeColor: Color(0xffCF50D8),
                                        // Radius of doughnut
                                        selectionBehavior: SelectionBehavior(
                                            unselectedColor: Color(0xffF8C0FC)),
                                        cornerStyle: CornerStyle.bothCurve,
                                        innerRadius: '80%',
                                      )
                                    ]),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (!controller.isSelected.value)
                                    Text("사용자 랭킹", style: leaderBoard_subtitle),
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
                                          ? Icon(Icons.close)
                                          : ListView.builder(
                                          itemCount: controller.rankingData.length,
                                          itemBuilder: (context, index) => Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 16,vertical: 4),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Text("${index + 1}", style: ranking_tiny_number,),
                                                  SizedBox(width: 10,),
                                                  Text("${controller.rankingData.value[index].name}", style: ranking_tiny_name,),
                                              ],
                                            ),
                                          ),)
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ]),
                    ),
                  ),
                  Container(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!controller.isSelected.value)
                        Text("이번주 학습량", style: leaderBoard_subtitle),
                      if (!controller.isSelected.value)
                        SizedBox(
                          height: 10,
                        ),
                      AnimatedContainer(
                        padding: EdgeInsets.only(top: 16,bottom: 8),
                        duration: Duration(milliseconds: 300),
                        decoration: buildBoxDecoration(),
                        width: controller.isSelected.value ? 0 : width * 0.84,
                        height: controller.isSelected.value ? 0 : height * 0.23,
                        child: WeeklyChart(),
                      )
                    ],
                  )),
                ],
              ),
            ),
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

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double y;
}

