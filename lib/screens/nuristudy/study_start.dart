import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harang/controllers/nuristudyController.dart';
import 'package:harang/screens/nuristudy/study_learn.dart';
import 'package:harang/themes/color_theme.dart';
import 'package:harang/themes/text_theme.dart';

import 'package:harang/widgets/circleinnershadow.dart';

class StudyStart extends GetView<NuriStudyController> {

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    int chapterNum = controller.chapter;
    int stageNum = controller.stageNum;
    int stageAmount = controller.chapterStageAmount[chapterNum];
    String color = controller.chapterColor[chapterNum];

    Map studyStartBtn = {
      "default": {
        "dropShadow": [
          BoxShadow(
            color: Colors.white,
            offset: Offset(-12, -12),
            blurRadius: 24,
          ),
          BoxShadow(
            color: controller.colorMap[color]["startBtnShadow"],
            offset: Offset(12, 12),
            blurRadius: 24,
          )
        ],
        "innerShadow": Stack()
      },
      "onClick": {
        "dropShadow": [
          BoxShadow(
            color: emptyColor,
          )
        ],
        "innerShadow": Stack(
          alignment: Alignment.center,
          children: [
            ClipPath(
              clipper: ShadowClipper(),
              child: CircleInnerShadow(
                shadowColor: controller.colorMap[color]["startBtnShadow"],
                backgroundColor: controller.colorMap[color]["startBtn_onClick"],
              ),
            ),
            Transform.rotate(
              angle: 1 * pi,
              child: ClipPath(
                clipper: ShadowClipper(),
                child: CircleInnerShadow(
                  shadowColor: Colors.white,
                  backgroundColor: controller.colorMap[color]["startBtn_onClick"],
                ),
              ),
            )
          ],
        )
      }
    };

    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              color: controller.colorMap[color]["background"],
              width: _width,
              height: _height,
            ),
            Positioned(
              top: 0,
              child: TeaserTopImage(height: _height, width: _width, imageName: "stage_$chapterNum.png", backgroundColor: controller.colorMap[color]["teaserTop"]),
            ),
            Positioned(
              top: _height * 0.455,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: _width,
                  ),
                  Container(
                      width: _width * 0.14,
                      height: _height * 0.0325,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: controller.colorMap[color]["stageBox"],
                      ),
                      child: Center(
                        child: Text(
                          "$stageNum/$stageAmount",
                          style: stepStudy_startPage_stageNum,
                          textAlign: TextAlign.center,
                        ),
                      )
                  ),
                  SizedBox(
                    height: _height * 0.04,
                  ),
                  Text(
                    controller.chapterContent[chapterNum][stageNum]["title"],
                    style: controller.colorMap[color]["titleStyle"],
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: _height * 0.02,
                  ),
                  Text(
                    (controller.chapterContent[chapterNum][stageNum]["description"] as String).replaceAll("\\n", "\n"),
                    style: controller.colorMap[color]["descriptionStyle"],
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: _height * 0.0225,
                  ),
                  Obx(
                      () => GestureDetector(
                        onTap: () {
                          controller.pageNum = 1;
                          controller.finalProvisionPoint = controller.chapterContent[chapterNum][stageNum]["point"];
                          Get.to(StudyLearn(), transition: Transition.rightToLeft);
                        },
                        onTapDown: (TapDownDetails tapDownDetails) => controller.startPage_startBtnType.value = "onClick",
                        onTapUp: (TapUpDetails tapUpDetails) => controller.startPage_startBtnType.value = "default",
                        onTapCancel: () => controller.startPage_startBtnType.value = "default",
                        child: Container(
                          height: _height * 0.3,
                          width: _width * 0.45,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: controller.colorMap[color]["startBtn_default"],
                            border: Border.all(color: controller.colorMap[color]["startBtnBorder"], width: 1),
                            boxShadow: studyStartBtn[controller.startPage_startBtnType.value]["dropShadow"],
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              studyStartBtn[controller.startPage_startBtnType.value]["innerShadow"],
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    controller.colorMap[color]["startBtnImg"],
                                    width: _width * 0.18,
                                  ),
                                  Text(
                                    "시작하기",
                                    style: controller.colorMap[color]["startBtnStyle"],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TeaserTopImage extends StatelessWidget {
  const TeaserTopImage({
    Key? key,
    required double height,
    required double width,
    required String imageName,
    required Color backgroundColor,
  }):   _height = height,
        _width = width,
        imageName = imageName,
        backgroundColor = backgroundColor,
        super(key: key);

  final double _height;
  final double _width;
  final String imageName;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: backgroundPainter(),
          child: Container(
            height: _height * 0.4,
            width: _width,
            decoration: BoxDecoration(color: backgroundColor),
            child: Stack(
              children: [
                Positioned(
                  top: _height * 0.045,
                  left: _width * 0.08,
                  child: Container(
                    height: _height * 0.5,
                    width: _width * 0.85,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Color(0x3DFFFFFF), width: 30),
                    ),
                  ),
                ),
                Positioned(
                    top: _height * 0.15,
                    left: _width * 0.26,
                    child: Image.asset(
                      'assets/images/studyNuri/$imageName',
                      width: _width * 0.45,
                    )
                ),
                Positioned(
                  top: _height * 0.06,
                  left: _width * 0.025,
                  child: GestureDetector(
                    onTap: () => Get.back(),
                    child: Icon(
                      Icons.chevron_left,
                      color: Colors.white,
                      size: _width * 0.12,
                    ),
                  )
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: _height * 0.43,
        ),
        Positioned(
            top: _height * 0.37,
            left: _width * 0.32,
            child: Image.asset(
              'assets/images/studyNuri/characterShadow.png',
              width: _width * 0.3,
            )
        ),
      ],
    );
  }
}

class backgroundPainter extends CustomClipper<Path> {

  @override
  Path getClip(Size size) {
    Path path = Path();

    final double _xScaling = size.width / 374;
    final double _yScaling = size.height / 286;

    path.lineTo(373.5 * _xScaling,0.5 * _yScaling);
    path.cubicTo(373.5 * _xScaling,0.5 * _yScaling,0 * _xScaling,1.99981 * _yScaling,0 * _xScaling,1.99981 * _yScaling,);
    path.cubicTo(0 * _xScaling,1.99981 * _yScaling,0 * _xScaling,278.5 * _yScaling,0 * _xScaling,278.5 * _yScaling,);
    path.cubicTo(3 * _xScaling,278.5 * _yScaling,13.5 * _xScaling,273.5 * _yScaling,24.5 * _xScaling,268 * _yScaling,);
    path.cubicTo(39.7 * _xScaling,258 * _yScaling,58.5 * _xScaling,255.5 * _yScaling,66.5 * _xScaling,255 * _yScaling,);
    path.cubicTo(82.5 * _xScaling,253 * _yScaling,102.5 * _xScaling,264.333 * _yScaling,110.5 * _xScaling,269.5 * _yScaling,);
    path.cubicTo(126.9 * _xScaling,285.1 * _yScaling,165.333 * _xScaling,286.5 * _yScaling,182.5 * _xScaling,285.5 * _yScaling,);
    path.cubicTo(197.3 * _xScaling,288.3 * _yScaling,222 * _xScaling,270.5 * _yScaling,233 * _xScaling,264 * _yScaling,);
    path.cubicTo(239 * _xScaling,259.6 * _yScaling,254.5 * _xScaling,253.666 * _yScaling,261.5 * _xScaling,251 * _yScaling,);
    path.cubicTo(281.9 * _xScaling,242.6 * _yScaling,313 * _xScaling,259 * _yScaling,326 * _xScaling,268 * _yScaling,);
    path.cubicTo(341.2 * _xScaling,283.2 * _yScaling,364 * _xScaling,282.5 * _yScaling,373.5 * _xScaling,281 * _yScaling,);
    path.cubicTo(373.5 * _xScaling,281 * _yScaling,373.5 * _xScaling,0.5 * _yScaling,373.5 * _xScaling,0.5 * _yScaling,);
    path.cubicTo(373.5 * _xScaling,0.5 * _yScaling,373.5 * _xScaling,0.5 * _yScaling,373.5 * _xScaling,0.5 * _yScaling,);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}

