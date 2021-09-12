import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harang/controllers/nuristudyController.dart';
import 'package:harang/screens/nuristudy/study_end.dart';
import 'package:harang/themes/color_theme.dart';
import 'package:harang/themes/text_theme.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class StudyLearn extends GetView<NuriStudyController> {
  late int chapterNum;
  late int stageNum;
  late String stageName;
  late String color;
  late Map colorMap;
  late int pageNum;
  late int pageAmount;
  late String pageKind; //text, quiz, code, blank
  late int point;
  late int quizStagePlusPoint;
  late int quizStageAnswer;
  late dynamic nextWindow;

  late double _height;
  late double _width;

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    chapterNum = controller.chapter;
    stageNum = controller.stageNum;
    stageName = controller.stageName;
    color = controller.chapterColor[chapterNum];
    colorMap = controller.colorMap;
    pageNum = controller.pageNum;
    pageAmount = controller.chapterContent[chapterNum][stageNum]["contents"]["pageAmount"];
    pageKind = controller.chapterContent[chapterNum][stageNum]["contents"][pageNum.toString()]["type"];
    point = controller.chapterContent[chapterNum][stageNum]["point"];

    pageNum++;

    Rx<Scaffold> result = Scaffold().obs;
    if (pageKind == "text") {
      result.value = textStageTemplate(
        Column(
          children: [
            Text(
              (controller.chapterContent[chapterNum][stageNum]["contents"][(pageNum-1).toString()]["content"] as String).replaceAll("\\n", "\n"),
              style: colorMap[color]["textStage_contentTextStyle"],
            ),
          ],
        ),
      );
    } else if (pageKind == "quiz") {
      quizStagePlusPoint = controller.chapterContent[chapterNum][stageNum]["contents"][(pageNum-1).toString()]["plusPoint"];
      quizStageAnswer = controller.chapterContent[chapterNum][stageNum]["contents"][(pageNum-1).toString()]["answer"];
      controller.quizStage_nowPlusPoint.value = quizStagePlusPoint;

      result.value = quizStageTemplate(
          (controller.chapterContent[chapterNum][stageNum]["contents"][(pageNum-1).toString()]["question"] as String).replaceAll("\\n", "\n"),
          controller.chapterContent[chapterNum][stageNum]["contents"][(pageNum-1).toString()]["choiceList"],
          point
      );
    }

    print(result.value);
    return Obx(() => result.value);
  }

  Scaffold textStageTemplate(Column educationContent) {
    return Scaffold (
        body: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                color: colorMap[color]["textStage_bottomBackground"],
                width: _width,
                height: _height,
              ),
              Positioned(
                top: 0,
                child: ClipPath(
                  clipper: textStageBottomDesignPainter(),
                  child: Container(
                    height: _height * 0.92,
                    width: _width,
                    decoration: BoxDecoration(color: colorMap[color]["textStage_background"]),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          top: _height * 0.05,
                          child: Container(
                            height: _height * 0.425,
                            width: _width * 0.75,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Color(0x66FFFFFF), width: 30),
                            ),
                          ),
                        ),
                        Positioned(
                          top: _height * 0.15,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  width: _width * 0.14,
                                  height: _height * 0.0325,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: colorMap[color]["textStage_stageNumBox"],
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
                                height: _height * 0.0225,
                              ),
                              Text(
                                stageName,
                                style: colorMap[color]["textStage_titleStyle"],
                              )
                            ],
                          ),
                        ),
                        Positioned(
                            top: _height * 0.26,
                            child: Container(
                              width: _width * 0.875,
                              height: _height * 0.55,
                              decoration: BoxDecoration(
                                color: colorMap[color]["textStage_contentBox"],
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                    color: colorMap[color]["textStage_contentBoxShadow"],
                                    offset: Offset(-8, 20),
                                    blurRadius: 25,
                                  ),
                                ],
                              ),
                              child: Stack(
                                alignment: Alignment.topCenter,
                                children: [
                                  Positioned(
                                    top: _height * 0.05,
                                    child: educationContent,
                                  ),
                                  Positioned(
                                      top: _height * 0.44,
                                      left: _width * 0.65,
                                      child: GestureDetector(
                                        onTap: () {
                                          if (pageNum <= pageAmount) { //다음 페이지가 있을 경우
                                            controller.pageRefresh();
                                          } else { //마지막 페이지일 경우
                                            Get.to(StudyEnd());
                                          }
                                        },
                                        child: Container(
                                          width: _width * 0.16,
                                          height: _width * 0.16,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: colorMap[color]["textStage_nextBtnShadow"],
                                                offset: Offset(-4, 8),
                                                blurRadius: 10,
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                'assets/images/studyNuri/nextPageBtnArrow.png',
                                                color: colorMap[color]["textStage_nextBtnArrow"],
                                                width: _width * 0.09,
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                  )
                                ],
                              ),
                            )
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }

  Scaffold quizStageTemplate(String question, Map choiceList, int point) {
    Map quizStageChooseBox = {
      "default": {
        "backgroundColor": Colors.white,
        "borderColor": colorMap[color]["quizStage_chooseBoxBorder"],
        "shadowColor": emptyColor,
        "circleColor": colorMap[color]["quizStage_chooseBoxCircle"],
        "textStyle": colorMap[color]["quizStage_chooseBoxTextStyle"],
      },
      "success": {
        "backgroundColor": mintThree,
        "borderColor": emptyColor,
        "shadowColor": mintThree_shadowThree,
        "circleColor": Colors.white,
        "textStyle": stepStudy_studyPage_quizStage_successFail_choiceText,
      },
      "fail": {
        "backgroundColor": redOne,
        "borderColor": emptyColor,
        "shadowColor": redOne_shadow,
        "circleColor": Colors.white,
        "textStyle": stepStudy_studyPage_quizStage_successFail_choiceText,
      }
    };

    return Scaffold (
        body: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          colorMap[color]["quizStage_topBackgroundGradient1"],
                          colorMap[color]["quizStage_topBackgroundGradient2"],
                        ]
                    )
                ),
                width: _width,
                height: _height,
              ),
              Positioned(
                top: _height * 0.25,
                child: ClipPath(
                  clipper: quizStageBottomDesignPainter(),
                  child: Container(
                    height: _height,
                    width: _width,
                    decoration: BoxDecoration(color: colorMap[color]["quizStage_background"]),
                  ),
                ),
              ),
              Positioned(
                  top: _height * 0.2,
                  child: Container(
                    height: _height * 0.28,
                    width: _width * 0.821,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: colorMap[color]["quizStage_questionBoxShadow"],
                          offset: Offset(0, 4),
                          blurRadius: 15,
                        )
                      ],
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          top: _height * 0.02,
                          left: _width * 0.05,
                          child: Text(
                            "${quizStagePlusPoint} 포인트",
                            style: stepStudy_learnPage_quiz_point,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Positioned(
                          child: Text(
                            question,
                            style: stepStudy_learnPage_quiz_question,
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  )
              ),
              Positioned(
                  top: _height * 0.15,
                  child: Container(
                    height: _width * 0.181,
                    width: _width * 0.181,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Obx(
                        () => Stack(
                          alignment: Alignment.center,
                          children: [
                            CircularPercentIndicator(
                              radius: _width * 0.15,
                              lineWidth: _width * 0.015,
                              animation: true,
                              percent: (controller.quizStage_nowPlusPoint.value / quizStagePlusPoint),
                              circularStrokeCap: CircularStrokeCap.round,
                              backgroundColor: Color(0xFFFFFF),
                              progressColor: colorMap[color]["quizStage_pointIndicator"],
                            ),
                            Text(
                              "${controller.quizStage_nowPlusPoint.value}",
                              style: stepStudy_learnPage_quiz_circleText,
                            )
                          ],
                        )
                    ),
                  )
              ),
              Positioned(
                  top: _height * 0.55,
                  child: SizedBox(
                    width: _width * 0.8,
                    height: _height * 0.6,
                    child: ListView.builder(
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Obx(
                                  () => GestureDetector(
                                    onTap: () => controller.quizAnswer((quizStageAnswer == (index+1)), index),
                                    child: Container(
                                      width: _width * 0.73,
                                      height: _height * 0.0775,
                                      decoration: BoxDecoration(
                                          color: quizStageChooseBox[controller.quizStage_chooseBoxType[index]]["backgroundColor"],
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(
                                              color: quizStageChooseBox[controller.quizStage_chooseBoxType[index]]["borderColor"],
                                              width: _width * 0.006
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: quizStageChooseBox[controller.quizStage_chooseBoxType[index]]["shadowColor"],
                                              offset: Offset(4, 4),
                                              blurRadius: 10,
                                            )
                                          ]
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: _width * 0.09,
                                            height: _width * 0.09,
                                            margin: EdgeInsets.only(left: _width * 0.035, right: _width * 0.045),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    color: quizStageChooseBox[controller.quizStage_chooseBoxType[index]]["circleColor"],
                                                    width: _width * 0.006
                                                )
                                            ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  (index+1).toString(),
                                                  style: quizStageChooseBox[controller.quizStage_chooseBoxType[index]]["textStyle"],
                                                )
                                              ],
                                            ),
                                          ),
                                          Text(
                                            choiceList[(index+1).toString()],
                                            style: quizStageChooseBox[controller.quizStage_chooseBoxType[index]]["textStyle"],
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                              ),
                              SizedBox(
                                height: _height * 0.02,
                              )
                            ],
                          );
                        }
                    ),
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
        )
    );
  }
}

class textStageBottomDesignPainter extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    final double _xScaling = size.width / 386;
    final double _yScaling = size.height / 706;

    path.lineTo(91.5 * _xScaling,673.5 * _yScaling);
    path.cubicTo(65.7918 * _xScaling,675.088 * _yScaling,21.7135 * _xScaling,705.378 * _yScaling,5 * _xScaling,696.5 * _yScaling,);
    path.cubicTo(5 * _xScaling,696.5 * _yScaling,0 * _xScaling,696.5 * _yScaling,0 * _xScaling,696.5 * _yScaling,);
    path.cubicTo(0 * _xScaling,696.5 * _yScaling,0 * _xScaling,0.5 * _yScaling,0 * _xScaling,0.5 * _yScaling,);
    path.cubicTo(0 * _xScaling,0.5 * _yScaling,388 * _xScaling,0.5 * _yScaling,388 * _xScaling,0.5 * _yScaling,);
    path.cubicTo(388 * _xScaling,0.5 * _yScaling,396 * _xScaling,701 * _yScaling,396 * _xScaling,701 * _yScaling,);
    path.cubicTo(396 * _xScaling,701 * _yScaling,379.5 * _xScaling,701 * _yScaling,379.5 * _xScaling,701 * _yScaling,);
    path.cubicTo(379.5 * _xScaling,701 * _yScaling,369.5 * _xScaling,698.5 * _yScaling,369.5 * _xScaling,698.5 * _yScaling,);
    path.cubicTo(327.85 * _xScaling,673.133 * _yScaling,310.911 * _xScaling,665.289 * _yScaling,297 * _xScaling,667.5 * _yScaling,);
    path.cubicTo(285.895 * _xScaling,667.89 * _yScaling,257.5 * _xScaling,683.5 * _yScaling,246.5 * _xScaling,690 * _yScaling,);
    path.cubicTo(235.5 * _xScaling,696.5 * _yScaling,216.222 * _xScaling,706.347 * _yScaling,188 * _xScaling,705.5 * _yScaling,);
    path.cubicTo(155.489 * _xScaling,707.981 * _yScaling,117.208 * _xScaling,671.912 * _yScaling,91.5 * _xScaling,673.5 * _yScaling,);
    path.cubicTo(91.5 * _xScaling,673.5 * _yScaling,91.5 * _xScaling,673.5 * _yScaling,91.5 * _xScaling,673.5 * _yScaling,);

    return path;
  }
  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}

class quizStageBottomDesignPainter extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    final double _xScaling = size.width / 375;
    final double _yScaling = size.height / 588;

    path.lineTo(0 * _xScaling,588 * _yScaling);
    path.cubicTo(0 * _xScaling,588 * _yScaling,0 * _xScaling,0.5 * _yScaling,0 * _xScaling,0.5 * _yScaling,);
    path.cubicTo(28.2222 * _xScaling,26.9832 * _yScaling,45.8666 * _xScaling,38.7327 * _yScaling,80 * _xScaling,55 * _yScaling,);
    path.cubicTo(120.398 * _xScaling,70.1684 * _yScaling,144.149 * _xScaling,74.828 * _yScaling,188 * _xScaling,77 * _yScaling,);
    path.cubicTo(200.714 * _xScaling,77.1122 * _yScaling,207.977 * _xScaling,76.5427 * _yScaling,221 * _xScaling,75 * _yScaling,);
    path.cubicTo(253.822 * _xScaling,69.5823 * _yScaling,272.502 * _xScaling,64.8932 * _yScaling,307 * _xScaling,50 * _yScaling,);
    path.cubicTo(335.246 * _xScaling,35.1363 * _yScaling,350.325 * _xScaling,24.9621 * _yScaling,375 * _xScaling,1.39364 * _yScaling,);
    path.cubicTo(375 * _xScaling,1.39364 * _yScaling,375 * _xScaling,588 * _yScaling,375 * _xScaling,588 * _yScaling,);
    path.cubicTo(375 * _xScaling,588 * _yScaling,0 * _xScaling,588 * _yScaling,0 * _xScaling,588 * _yScaling,);
    path.cubicTo(0 * _xScaling,588 * _yScaling,0 * _xScaling,588 * _yScaling,0 * _xScaling,588 * _yScaling,);
    return path;
  }
  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}