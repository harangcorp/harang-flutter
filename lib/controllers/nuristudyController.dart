import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';
import 'package:harang/models/lecture.dart';
import 'package:harang/models/user.dart';
import 'package:harang/screens/nuristudy/study_end.dart';
import 'package:harang/screens/nuristudy/study_learn.dart';
import 'package:harang/services/database.dart';
import 'package:harang/themes/color_theme.dart';
import 'package:harang/themes/text_theme.dart';


class NuriStudyController extends GetxController {
  int chapter = 1;
  int stageNum = 1;
  int pageNum = 1;
  String stageName = "";
  int finalProvisionPoint = 0;

  Map chapterColor = {};
  Map chapterContent = {};
  Map chapterStageAmount = {};

  late UserModel _user;
  Map stageProgress = {};

  RxMap quizStage_chooseBoxType = {
    0: "default",
    1: "default",
    2: "default",
    3: "default",
  }.obs;
  RxInt quizStage_nowPlusPoint = 0.obs;

  @override
  onInit() async {
    _user = await Database().getUser(FirebaseAuth.instance.currentUser?.uid);
    stageProgress = _user.stageProgress!;
  }

  Future<bool> getChapterContent() async {
    for (int i=1; i<=3; i++) {
      LectureContent _lectureContent = await Database().getLectureContent(i);

      chapterColor[i] = _lectureContent.chapterColor;
      chapterStageAmount[i] = _lectureContent.chapterStageAmount;

      chapterContent[i] = {};
      for (int j=1; j<=chapterStageAmount[i]; j++) {
        chapterContent[i][j] = _lectureContent.chapterContent![j];
      }
    }

    return true;
  }

  void goNextPage(int pageAmount) {
    pageNum++;

    if (pageNum <= pageAmount) { //다음 페이지가 있을 경우
      Get.back();
      Get.to(StudyLearn(), transition: Transition.rightToLeft);
    } else { //마지막 페이지일 경우
      pageNum = 1;
      Get.to(StudyEnd(), transition: Transition.rightToLeft);
    }
  }

  Future<void> quizAnswer(bool guessAnswer, int index, int pageAmount) async {
    if (guessAnswer) {
      quizStage_chooseBoxType[index] = "success";
    } else {
      quizStage_chooseBoxType[index] = "fail";

      Vibrate.vibrate();

      if (quizStage_nowPlusPoint.value != 0) {
        quizStage_nowPlusPoint.value -= 5;
      }
    }

    Future.delayed(
        Duration(seconds: 1),
        () {
          for (int i=0; i<4; i++) {
            quizStage_chooseBoxType[i] = "default";
          }

          if (guessAnswer) { goNextPage(pageAmount); }
        }
    );
  }

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
      "startBtnImg": "assets/images/studyNuri/startBtn_mint.png",

      "stageBoxInList_background": mintTwo,
      "stageBoxInList_border": mintThree,
      "stageBoxInList_shadow": mintThree_shadow,
      "stageBoxInList_stageNameStyle": stepStudy_startPage_mint_stageName,

      "textStage_background": mint,
      "textStage_bottomBackground": mintTwo,
      "textStage_stageNumBox": mintThree,
      "textStage_titleStyle": stepStudy_studyPage_textStage_mint_title,
      "textStage_contentBox": mintTwo,
      "textStage_contentBoxShadow": mintThree_shadow,
      "textStage_contentTextStyle": stepStudy_studyPage_textStage_mint_contentDefault,
      "textStage_nextBtnArrow": mintThree,
      "textStage_nextBtnShadow": mintThree_shadow,

      "quizStage_background": mintTwo,
      "quizStage_topBackgroundGradient1": mint,
      "quizStage_topBackgroundGradient2": Color(0x2CBCA3),
      "quizStage_questionBoxShadow": mintThree_shadow,
      "quizStage_pointIndicator": mintThree,
      "quizStage_chooseBoxBorder": mintThree,
      "quizStage_chooseBoxCircle": mintThree,
      "quizStage_chooseBoxTextStyle": stepStudy_studyPage_quizStage_mint_choiceText,

      "endPage_background": mintEight,
      "endPage_decoration": mint,
      "endPage_boxColor": mintTwo,
      "endPage_boxShadow": mintThree_shadowTwo,
      "endPage_closeIconColor": mintThree,
      "endPage_titleStyle": stepStudy_endPage_mint_title,
      "endPage_congratsTextStyle": stepStudy_endPage_mint_congratsText,
      "endPage_resultTextStyle": stepStudy_endPage_mint_resultText,
      "endPage_finishIconImg": "assets/images/studyNuri/finishIcon_mint.png",
      "endPage_textDecorationColor": mintThree,
      "endPage_pointCircle": mintThree,
      "endPage_pointTextStyle": stepStudy_endPage_mint_pointText,
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
      "startBtnImg": "assets/images/studyNuri/startBtn_purple.png",

      "stageBoxInList_background": purpleFive,
      "stageBoxInList_border": purpleSeven,
      "stageBoxInList_shadow": purpleShadow2,
      "stageBoxInList_stageNameStyle": stepStudy_startPage_purple_stageName,

      "textStage_background": purpleThree,
      "textStage_bottomBackground": purpleTen,
      "textStage_stageNumBox": purpleSeven,
      "textStage_titleStyle": stepStudy_studyPage_textStage_purple_title,
      "textStage_contentBox": purpleTen,
      "textStage_contentBoxShadow": purpleSeven_shadow,
      "textStage_contentTextStyle": stepStudy_studyPage_textStage_purple_contentDefault,
      "textStage_nextBtnArrow": purpleSeven,
      "textStage_nextBtnShadow": purpleSeven_shadow,

      "quizStage_background": purpleNine,
      "quizStage_topBackgroundGradient1": purpleThree,
      "quizStage_topBackgroundGradient2": Color(0x669896F1),
      "quizStage_questionBoxShadow": purpleTwelve,
      "quizStage_pointIndicator": purpleEight,
      "quizStage_chooseBoxBorder": purpleEight,
      "quizStage_chooseBoxCircle": purpleEight,
      "quizStage_chooseBoxTextStyle": stepStudy_studyPage_quizStage_purple_choiceText,

      "endPage_background": purpleNine,
      "endPage_decoration": purpleThree,
      "endPage_boxColor": purpleTen,
      "endPage_boxShadow": purpleShadow3,
      "endPage_closeIconColor": purpleEleven,
      "endPage_titleStyle": stepStudy_endPage_purple_title,
      "endPage_congratsTextStyle": stepStudy_endPage_purple_congratsText,
      "endPage_resultTextStyle": stepStudy_endPage_purple_resultText,
      "endPage_finishIconImg": "assets/images/studyNuri/finishIcon_purple.png",
      "endPage_textDecorationColor": purpleSeven,
      "endPage_pointCircle": purpleEight,
      "endPage_pointTextStyle": stepStudy_endPage_purple_pointText,
    },
    "pink": {
      "teaserTop": purpleOne,
      "background": pinkOne,
      "stageBox": nuriPracticalApplication,
      "startBtn": pinkOne,
      "startBtnShadow": purpleOne,
      "startBtnBorder": Color(0xFFF3FFFD),
      "titleStyle": stepStudy_startPage_pink_title,
      "descriptionStyle": stepStudy_startPage_pink_description,
      "startBtnStyle": stepStudy_startPage_pink_startButton,
      "startBtnImg": "assets/images/studyNuri/startBtn_pink.png",

      "stageBoxInList_background": pinkOne,
      "stageBoxInList_border": nuriPracticalApplication,
      "stageBoxInList_shadow": purpleTwo,
      "stageBoxInList_stageNameStyle": stepStudy_startPage_pink_stageName,

      "textStage_background": purpleOne,
      "textStage_bottomBackground": pinkOne,
      "textStage_stageNumBox": nuriPracticalApplication,
      "textStage_titleStyle": stepStudy_studyPage_textStage_pink_title,
      "textStage_contentBox": pinkOne,
      "textStage_contentBoxShadow": pinkShadowThree,
      "textStage_contentTextStyle": stepStudy_studyPage_textStage_pink_contentDefault,
      "textStage_nextBtnArrow": nuriPracticalApplication,
      "textStage_nextBtnShadow": pinkShadowTwo,

      "endPage_background": pinkThree,
      "endPage_decoration": purpleOne,
      "endPage_boxColor": pinkOne,
      "endPage_boxShadow": pinkShadow,
      "endPage_closeIconColor": purpleEleven,
      "endPage_titleStyle": stepStudy_endPage_pink_title,
      "endPage_congratsTextStyle": stepStudy_endPage_pink_congratsText,
      "endPage_resultTextStyle": stepStudy_endPage_pink_resultText,
      "endPage_finishIconImg": "assets/images/studyNuri/finishIcon_pink.png",
      "endPage_textDecorationColor": nuriPracticalApplication,
      "endPage_pointCircle": nuriPracticalApplication,
      "endPage_pointTextStyle": stepStudy_endPage_pink_pointText,
    },
  };
}
