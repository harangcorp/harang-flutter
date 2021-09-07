import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harang/models/lecture.dart';
import 'package:harang/models/user.dart';
import 'package:harang/services/database.dart';
import 'package:harang/themes/color_theme.dart';
import 'package:harang/themes/text_theme.dart';


class NuriStudyController extends GetxController {
  int chapter = 1; //초기값 설정
  int stageNum = 1; //초기값 설정
  String stageName = "";

  Map chapterColor = {};
  Map chapterContent = {};
  Map chapterStageAmount = {};

  late UserModel _user;
  Map stageProgress = {};

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

      "endPage_background": mintEight,
      "endPage_decoration": mint,
      "endPage_boxColor": mintTwo,
      "endPage_boxShadow": mintThree_shadowTwo,
      "endPage_closeIconColor": mintThree,
      "endPage_titleStyle": stepStudy_endPage_mint_title,
      "endPage_congratsTextStyle": stepStudy_endPage_mint_congratsText,
      "endPage_resultTextStyle": stepStudy_endPage_mint_resultText,
      "endPage_finishIconImg": "assets/images/studyNuri/finishIcon_mint.png",
      "endPage_textDecorationColor": mintThree
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

      "endPage_background": purpleNine,
      "endPage_decoration": purpleThree,
      "endPage_boxColor": purpleTen,
      "endPage_boxShadow": purpleShadow3,
      "endPage_closeIconColor": purpleEleven,
      "endPage_titleStyle": stepStudy_endPage_purple_title,
      "endPage_congratsTextStyle": stepStudy_endPage_purple_congratsText,
      "endPage_resultTextStyle": stepStudy_endPage_purple_resultText,
      "endPage_finishIconImg": "assets/images/studyNuri/finishIcon_purple.png",
      "endPage_textDecorationColor": purpleSeven
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

      "endPage_background": pinkThree,
      "endPage_decoration": purpleOne,
      "endPage_boxColor": pinkOne,
      "endPage_boxShadow": pinkShadow,
      "endPage_closeIconColor": purpleEleven,
      "endPage_titleStyle": stepStudy_endPage_pink_title,
      "endPage_congratsTextStyle": stepStudy_endPage_pink_congratsText,
      "endPage_resultTextStyle": stepStudy_endPage_pink_resultText,
      "endPage_finishIconImg": "assets/images/studyNuri/finishIcon_pink.png",
      "endPage_textDecorationColor": nuriPracticalApplication
    },
  };
}
