import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harang/screens/study_nuri/chapters/1_world_of_coding/stage1_worldOfZeroAndOne.dart';
import 'package:harang/screens/study_nuri/chapters/1_world_of_coding/stage2_whatIsProgramming.dart';
import 'package:harang/themes/color_theme.dart';
import 'package:harang/themes/text_theme.dart';

class StudyStart extends StatefulWidget {
  const StudyStart({Key? key, required int chapterNum, required int stageNum })
      : chapterNum = chapterNum, stageNum = stageNum, super(key: key);

  final int chapterNum;
  final int stageNum;


  @override
  _StudyStartState createState() => _StudyStartState(chapterNum: chapterNum, stageNum: stageNum);
}

class _StudyStartState extends State<StudyStart> {
  final int chapterNum;
  final int stageNum;

  _StudyStartState({required this.chapterNum, required this.stageNum});

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    String color = studyContentMap[chapterNum]["color"];

    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              color: colorMap[color]["background"],
              width: _width,
              height: _height,
            ),
            Positioned(
              top: 0,
              child: TeaserTopImage(height: _height, width: _width, imageName: "stage_${chapterNum}_$stageNum.png", backgroundColor: colorMap[color]["teaserTop"]),
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
                        color: colorMap[color]["stageBox"],
                      ),
                      child: Center(
                        child: Text(
                          "$stageNum/4",
                          style: stepStudy_startPage_stageNum,
                          textAlign: TextAlign.center,
                        ),
                      )
                  ),
                  SizedBox(
                    height: _height * 0.04,
                  ),
                  Text(
                    studyContentMap[chapterNum][stageNum]["title"],
                    style: colorMap[color]["titleStyle"],
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: _height * 0.02,
                  ),
                  Text(
                    studyContentMap[chapterNum][stageNum]["description"],
                    style: colorMap[color]["descriptionStyle"],
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: _height * 0.0225,
                  ),
                  GestureDetector(
                    onTap: () => Get.to(studyContentMap[chapterNum][stageNum]["content"]),
                    child: Container(
                      height: _height * 0.3,
                      width: _width * 0.45,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: colorMap[color]["startBtn"],
                        border: Border.all(color: colorMap[color]["startBtnBorder"], width: 1),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(-12, -12),
                            blurRadius: 24,
                          ),
                          BoxShadow(
                            color: colorMap[color]["startBtnShadow"],
                            offset: Offset(12, 12),
                            blurRadius: 24,
                          )
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            colorMap[color]["startBtnImg"],
                            width: _width * 0.18,
                          ),
                          Text(
                            "시작하기",
                            style: colorMap[color]["startBtnStyle"],
                          ),
                        ],
                      ),
                    ),
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

final Map studyContentMap = {
    1: {
      "color": "mint",
      1: {
        "title": "0과 1로 이루어진 세상",
        "description": "스테이지 설명 아주 간략하게 한두 줄 정도로만 \n바로 여기에 적어주세요.",
        "content": Stage1_WorldOfZeroAndOne(),
      },
      2: {
        "title": "프로그래밍이란?",
        "description": "스테이지 설명 아주 간략하게 한두 줄 정도로만 \n바로 여기에 적어주세요.",
        "content": Stage2_WhatIsProgramming(),
      }
    },
  2: {
    "color": "purple",
    1: {
      "title": "화면에 출력하기",
      "description": "스테이지 설명 아주 간략하게 한두 줄 정도로만 \n바로 여기에 적어주세요.",
      "content": Stage1_WorldOfZeroAndOne(),
    }
  },
};

final Map colorMap = {
  "mint": {
    "teaserTop": mint,
    "background": mintTwo,
    "stageBox": mintThree,
    "startBtn": mintFive,
    "startBtnShadow": mintSix,
    "startBtnBorder": Color(0x80F3FFFD),
    "titleStyle": stepStudy_startPage_mint_title,
    "descriptionStyle": stepStudy_startPage_mint_description,
    "startBtnStyle": stepStudy_startPage_mint_startButton,
    "startBtnImg": "assets/images/studyNuri/startBtn_mint.png"
  },
  "purple": {
    "teaserTop": purpleThree,
    "background": purpleFive,
    "stageBox": purpleSeven,
    "startBtn": purpleSix,
    "startBtnShadow": purpleShadow2,
    "startBtnBorder": Color(0xFFF3FFFD),
    "titleStyle": stepStudy_startPage_purple_title,
    "descriptionStyle": stepStudy_startPage_purple_description,
    "startBtnStyle": stepStudy_startPage_purple_startButton,
    "startBtnImg": "assets/images/studyNuri/startBtn_purple.png"
  },
};
