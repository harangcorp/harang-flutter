import 'package:dio/dio.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:harang/controllers/nuripgController.dart';
import 'package:harang/controllers/nuristudyController.dart';
import 'package:harang/screens/nuriplayground/nuriplayground.dart';
import 'package:harang/themes/color_theme.dart';
import 'package:harang/themes/harang_theme.dart';
import 'package:harang/themes/text_theme.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class StudyLearn extends GetView<NuriStudyController> {
  late int chapterNum;
  late int stageNum;
  late String stageName;
  late int stageAmount;
  late String color;
  late Map colorMap;
  late int pageNum;
  late int pageAmount;
  late String pageKind; //text, quiz, code, blank
  late int point;
  late int quizStagePlusPoint;
  late int quizStageAnswer;

  late double _height;
  late double _width;

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    chapterNum = controller.chapter;
    stageNum = controller.stageNum;
    stageName = controller.stageName;
    stageAmount = controller.chapterStageAmount[chapterNum];
    color = controller.chapterColor[chapterNum];
    colorMap = controller.colorMap;
    pageNum = controller.pageNum;
    pageAmount = controller.chapterContent[chapterNum][stageNum]["contents"]["pageAmount"];
    pageKind = controller.pageKind;
    point = controller.chapterContent[chapterNum][stageNum]["point"];


    var result = Stack();
    if (pageKind == "text") {
      TextStyle contentTextStyle = TextStyle(
          fontSize: (_width * 0.0375), color: colorMap[color]["textStage_contentTextColor"], fontFamily: 'NotoSansKR', fontWeight: FontWeight.w500, height: 2.1);


      List<Widget> contentWidgetList = [];
      String content = (controller.chapterContent[chapterNum][stageNum]["contents"][pageNum.toString()]["content"] as String).replaceAll("\\n", "\n");
      int nowIndex = 0;
      int beforeIndex = 0;

      contentLoop: while (true) {
        if (!content.contains("<img num", nowIndex)) {
          contentWidgetList.add(Text(content.substring(beforeIndex), style: contentTextStyle));
          break contentLoop;
        }
        int index = content.indexOf("<img num", nowIndex);

        contentWidgetList.add(Text(content.substring(beforeIndex, index), style: contentTextStyle));
        contentWidgetList.add(ExtendedImage.network(controller.chapterContentImageUrl[chapterNum]["${stageNum}_${pageNum}_${content.substring(index+9, content.indexOf(">", index))}"], cache: true));

        nowIndex = index+1;
        beforeIndex = content.indexOf(">", index)+1;
      }

      if (contentWidgetList.isEmpty) { contentWidgetList.add(Text(content, style: contentTextStyle)); }

      result = textStageTemplate(contentWidgetList);
    } else if (pageKind == "quiz") {
      quizStagePlusPoint = controller.chapterContent[chapterNum][stageNum]["contents"][pageNum.toString()]["plusPoint"];
      quizStageAnswer = controller.chapterContent[chapterNum][stageNum]["contents"][pageNum.toString()]["answer"];
      controller.quizStage_nowPlusPoint.value = quizStagePlusPoint;

      result = quizStageTemplate(
          (controller.chapterContent[chapterNum][stageNum]["contents"][pageNum.toString()]["question"] as String).replaceAll("\\n", "\n"),
          controller.chapterContent[chapterNum][stageNum]["contents"][pageNum.toString()]["choiceList"],
          point
      );
    } else if (pageKind == "quizStart") {
      quizStagePlusPoint = controller.chapterContent[chapterNum][stageNum]["contents"][(pageNum+1).toString()]["plusPoint"];
      result = quizStageStartPage();
    } else if (pageKind == "code") {
      result = codeStageTemplate(
          context
      );
    }

    return Scaffold(
      body: Center(
          child: result
      ),
    );
  }

  textStageTemplate(List<Widget> educationContent) {
    return Stack(
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
            clipper: textAndCodeStageBottomDesignPainter(),
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
                                "$stageNum/$stageAmount",
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
                              top: _height * 0.03,
                              left: _width * 0.065,
                              child: Container(
                                  width: _width * 0.775,
                                  height: _height * 0.42,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Theme(
                                          data: harang_theme.copyWith(
                                            scrollbarTheme: harang_theme.scrollbarTheme.copyWith(
                                              thumbColor: MaterialStateProperty.all(colorMap[color]["textStage_scrollBar"].withOpacity(0.85)),
                                            )
                                          ),
                                          child: Scrollbar(
                                              child: SizedBox(
                                                  width: _width * 0.75,
                                                  height: _height * 0.42,
                                                  child: SingleChildScrollView(
                                                      scrollDirection: Axis.vertical,
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: educationContent,
                                                      ),
                                                  )
                                              )
                                          ),
                                        )
                                      )
                                    ],
                                  )
                              ),
                            ),
                            Positioned(
                                top: _height * 0.44,
                                left: _width * 0.65,
                                child: GestureDetector(
                                  onTap: () {
                                    controller.goNextPage(pageAmount);
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
    );
  }

  quizStageStartPage() {
    return Stack(
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
        Container(
            height: _height * 0.475,
            width: _width * 0.88,
            decoration: BoxDecoration(
              color: controller.colorMap[color]["endPage_boxColor"],
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: controller.colorMap[color]["quizStage_startPageBoxShadow"],
                  offset: Offset(-8, 20),
                  blurRadius: 30,
                )
              ],
            ),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Column(
                  children: [
                    SizedBox(height: _height * 0.03),
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
                    SizedBox(height: _height * 0.015),
                    Text(
                      controller.stageName,
                      style: controller.colorMap[color]["endPage_titleStyle"],
                    ),
                    SizedBox(height: _height * 0.05),
                    Image.asset(
                      'assets/images/studyNuri/gameIcon_$color.png',
                      width: _width * 0.3,
                    ),
                    Text(
                      "오늘 배운 내용을\n퀴즈로 재밌게 복습해봐요!",
                      textAlign: TextAlign.center,
                      style: controller.colorMap[color]["quizStage_startPageTextStyle"],
                    )
                  ],
                ),
                Positioned(
                  top: _height * 0.1425,
                  left: _width * 0.64,
                  child: Container(
                      width: _width * 0.18,
                      height: _height * 0.04,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: controller.colorMap[color]["quizStage_startPageBoxColor"],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: _width * 0.055,
                            height: _width * 0.055,
                            margin: EdgeInsets.only(left: _width * 0.015, right: _width * 0.0175),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "assets/images/studyNuri/endPage_pointStar.svg",
                                  color: controller.colorMap[color]["endPage_pointCircle"],
                                  fit: BoxFit.contain,
                                  width: _width * 0.035,
                                )
                              ],
                            ),
                          ),
                          Text(
                            "+$quizStagePlusPoint",
                            style: stepStudy_studyPage_quizStage_startPage_pointText
                          )
                        ],
                      )
                  ),
                ),
                Positioned(
                    top: _height * 0.36,
                    left: _width * 0.68,
                    child: GestureDetector(
                      onTap: () {
                        controller.goNextPage(pageAmount);
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
            )
        ),
      ],
    );
  }

  quizStageTemplate(String question, Map choiceList, int point) {
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

    return Stack(
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
                      "$quizStagePlusPoint 포인트",
                      style: colorMap[color]["quizStage_pointTextStyle"],
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Positioned(
                    child: Text(
                      question,
                      style: stepStudy_studyPage_quizStage_question,
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
              child: Obx(() => Stack(
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
                        style: colorMap[color]["quizStage_circlePointTextStyle"],
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
                        Obx(() => GestureDetector(
                              onTap: () {
                                if (!controller.quizStage_nowGrade.value) { controller.quizAnswer((quizStageAnswer == (index+1)), index); }
                              },
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
                                      margin: EdgeInsets.only(left: _width * 0.035, right: _width * 0.025),
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
                                      (choiceList[(index+1).toString()] as String).replaceAll("\\n", "\n"),
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
    );
  }

  codeStageTemplate(BuildContext context) {
    Get.lazyPut(() => Dio());

    return Stack(
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
            clipper: textAndCodeStageBottomDesignPainter(),
            child: Container(
              height: _height * 0.92,
              width: _width,
              decoration: BoxDecoration(color: colorMap[color]["textStage_background"]),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: _height * 0.09,
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
                                "$stageNum/$stageAmount",
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
                    top: _height * 0.2,
                    child: SizedBox(
                      width: _width * 0.875,
                      child: GetBuilder<NuripgController> (
                        init: NuripgController(),
                        builder: (nuriPgController) =>  NuriPlayGround().codeWriteUI(context, nuriPgController, controller, color, "stepStudy"),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class textAndCodeStageBottomDesignPainter extends CustomClipper<Path> {
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