import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:harang/controllers/nuripgController.dart';
import 'package:harang/models/lecture.dart';
import 'package:harang/models/nuri.dart';
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
  String pageKind = "text";
  String stageName = "";
  RxInt finalProvisionPoint = 0.obs;

  Map chapterColor = {};
  Map chapterContent = {};
  Map chapterContentImageUrl = {};
  Map chapterStageAmount = {};

  late UserModel _user;
  Map stageProgress = {};

  RxString startPage_startBtnType = "default".obs;

  RxMap quizStage_chooseBoxType = {
    0: "default",
    1: "default",
    2: "default",
    3: "default",
  }.obs;
  RxInt quizStage_nowPlusPoint = 0.obs;
  RxBool quizStage_nowGrade = false.obs;

  late FToast fToast;

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
      chapterContentImageUrl[i] = {};
      for (int j=1; j<=chapterStageAmount[i]; j++) {
        chapterContent[i][j] = _lectureContent.chapterContent![j];

        for (int k=1; k<=chapterContent[i][j]["contents"]["pageAmount"]; k++) {
          if (chapterContent[i][j]["contents"][k.toString()]["type"] == "text") {
            String content = chapterContent[i][j]["contents"][k.toString()]["content"];

            int nowIndex = 0;
            getContentImageLoop: while (true) {
              if (!content.contains("<img num", nowIndex)) { break getContentImageLoop; }
              int index = content.indexOf("<img num", nowIndex);
              getImageUrl(i, j, k, int.parse(content.substring(index+9, content.indexOf(">", index))));
              nowIndex = index+1;
            }
          }
        }
      }
    }

    return true;
  }

  getImageUrl(int chapter, int stage, int page, int imageNum) async {
    final ref = FirebaseStorage.instance.ref().child('lectures/chapter${chapter}/${stage}_${page}_${imageNum}.png');
    String result = await ref.getDownloadURL();

    chapterContentImageUrl[chapter]["${stage}_${page}_${imageNum}"] = result;
  }

  goNextPage(int pageAmount) async {
    pageNum++;
    if (pageNum <= pageAmount) { //다음 페이지가 있을 경우
      pageKindLoop: for (int i=1; i<=pageAmount; i++) {
        String pageKind = chapterContent[chapter][stageNum]["contents"][i.toString()]["type"];
        if (i == pageNum && pageKind == "quiz" && this.pageKind != "quizStart") { //스테이지의 첫 퀴즈 스테이지 일 경우
          this.pageKind = "quizStart";
          pageNum--;
          break pageKindLoop;
        } else if (i == pageNum) {
          this.pageKind = chapterContent[chapter][stageNum]["contents"][pageNum.toString()]["type"];
          break pageKindLoop;
        }
      }

      Get.back();
      Get.to(StudyLearn(), transition: Transition.rightToLeft);
    } else { //마지막 페이지일 경우
      await addPointToPlayer();
      await unlockNextStage();

      pageNum = 1;
      Get.to(StudyEnd(), transition: Transition.rightToLeft);
    }
  }

  addPointToPlayer() async {
    bool isNotFirstClearStage = false;
    if (chapterStageAmount[chapter] != stageNum) { //챕터의 마지막 스테이지가 아닐경우
      isNotFirstClearStage = stageProgress[chapter.toString()][(stageNum+1).toString()] ?? false;
    } else { //챕터의 마지막 스테이지일 경우
      if (chapter != 3) {
        isNotFirstClearStage = stageProgress[(chapter+1).toString()]["1"] ?? false;
      }
    }

    if (isNotFirstClearStage) {
      finalProvisionPoint.value = (finalProvisionPoint - chapterContent[chapter][stageNum]["point"]).toInt();
    }

    await Database().plusUserPoint(finalProvisionPoint.value);
  }

  unlockNextStage() async {
    if (chapterStageAmount[chapter] != stageNum) { //챕터의 마지막 스테이지가 아닐경우
      stageProgress["requiredStage"] = "$chapter-${stageNum+1}";
      stageProgress[chapter.toString()][(stageNum+1).toString()] = true;
    } else { //챕터의 마지막 스테이지일 경우
      if (chapter != 3) {
        stageProgress["requiredStage"] = "${chapter+1}-1";
        stageProgress[(chapter+1).toString()]["1"] = true;
      }
    }

    await Database().unlockNextStage(stageProgress);
  }

  Future<void> quizAnswer(bool guessAnswer, int index) async {
    quizStage_nowGrade.value = true;

    int pageAmount = chapterContent[chapter][stageNum]["contents"]["pageAmount"];

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

          if (guessAnswer) {
            finalProvisionPoint += quizStage_nowPlusPoint.value;

            goNextPage(pageAmount);
          }
          quizStage_nowGrade.value = false;
        }
    );
  }

  checkCorrectCode(BuildContext context, NuripgController nuriPgController) async {
    fToast = FToast();
    fToast.init(context);

    int pageAmount = chapterContent[chapter][stageNum]["contents"]["pageAmount"];
    String testCaseInput = chapterContent[chapter][stageNum]["contents"][pageNum.toString()]["testCase"]["input"];
    String testCaseOutput = chapterContent[chapter][stageNum]["contents"][pageNum.toString()]["testCase"]["output"];

    nuriPgController.compile();
    Nuri testCaseResult = await nuriPgController.nuriAPI.postReq(nuriPgController.replaceIphoneUniqueStr(nuriPgController.codeCtl.text), input: testCaseInput);

    String compareOutputText = testCaseResult.output;
    if (compareOutputText.length != 0) {
      compareOutputText = testCaseResult.output.substring(0, (testCaseResult.output.length-1));
    }

    if (compareOutputText == testCaseOutput) { //맞을시
      fToast.showToast(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color: mintThree,
            boxShadow: [
              BoxShadow(
                color: mintThree_shadowFour,
                offset: Offset(0, 7),
                blurRadius: 7,
              ),
            ]
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check_circle_outline_rounded,
                color: Colors.white,
              ),
              SizedBox(
                width: 12.0,
              ),
              Text(
                "정답입니다!",
                style: stepStudy_studyPage_codeStage_toastText,

              ),
            ],
          ),
        ),
        gravity: ToastGravity.BOTTOM,
        toastDuration: Duration(seconds: 2),
      );

      Future.delayed(
          Duration(seconds: 2),
              () {
            goNextPage(pageAmount);
          }
      );
    } else {
      fToast.showToast(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color: redOne,
            boxShadow: [
              BoxShadow(
                color: redOne_shadowTwo,
                offset: Offset(0, 7),
                blurRadius: 7,
              ),
            ]
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              RotationTransition(
                turns: AlwaysStoppedAnimation(45 / 360),
                child: Icon(
                  Icons.add_circle_outline_rounded,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 12.0,
              ),
              Text(
                "다시 도전해봐요!",
                style: stepStudy_studyPage_codeStage_toastText,
              ),
            ],
          ),
        ),
        gravity: ToastGravity.BOTTOM,
        toastDuration: Duration(seconds: 2),
      );

    }
  }

  final Map colorMap = {
    "mint": {
      "teaserTop": mint,
      "background": mintTwo,
      "stageBox": mintThree,
      "startBtn_default": mintFive,
      "startBtn_onClick": mintFive,
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
      "textStage_contentTextColor": mintFour,
      "textStage_scrollBar": mintThree,
      "textStage_nextBtnArrow": mintThree,
      "textStage_nextBtnShadow": mintThree_shadow,

      "quizStage_background": mintTwo,
      "quizStage_topBackgroundGradient1": mint,
      "quizStage_topBackgroundGradient2": Color(0x2CBCA3),
      "quizStage_questionBoxShadow": mintThree_shadow,
      "quizStage_pointIndicator": mintThree,
      "quizStage_chooseBoxBorder": mintThree,
      "quizStage_chooseBoxCircle": mintThree,
      "quizStage_startPageBoxColor": mintThree,
      "quizStage_startPageBoxShadow": mint_shadowTwo,
      "quizStage_chooseBoxTextStyle": stepStudy_studyPage_quizStage_mint_choiceText,
      "quizStage_pointTextStyle": stepStudy_studyPage_quizStage_mint_point,
      "quizStage_circlePointTextStyle": stepStudy_studyPage_quizStage_mint_circleText,
      "quizStage_startPageTextStyle": stepStudy_studyPage_quizStage_startPage_mint_pageText,

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
      "startBtn_default": purpleTen,
      "startBtn_onClick": purpleSix,
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
      "textStage_contentTextColor": nuriGrammar,
      "textStage_scrollBar": purpleSeven,
      "textStage_nextBtnArrow": purpleSeven,
      "textStage_nextBtnShadow": purpleSeven_shadow,

      "quizStage_background": purpleNine,
      "quizStage_topBackgroundGradient1": purpleThree,
      "quizStage_topBackgroundGradient2": Color(0x669896F1),
      "quizStage_questionBoxShadow": purpleTwelve,
      "quizStage_pointIndicator": purpleEight,
      "quizStage_chooseBoxBorder": purpleEight,
      "quizStage_chooseBoxCircle": purpleEight,
      "quizStage_startPageBoxColor": purpleEight,
      "quizStage_startPageBoxShadow": purpleShadow3,
      "quizStage_chooseBoxTextStyle": stepStudy_studyPage_quizStage_purple_choiceText,
      "quizStage_pointTextStyle": stepStudy_studyPage_quizStage_purple_point,
      "quizStage_circlePointTextStyle": stepStudy_studyPage_quizStage_purple_circleText,
      "quizStage_startPageTextStyle": stepStudy_studyPage_quizStage_startPage_purple_pageText,

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
      "startBtn_default": pinkOne,
      "startBtn_onClick": pinkOne,
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
      "textStage_contentTextColor": nuriPracticalApplication,
      "textStage_scrollBar": nuriPracticalApplication,
      "textStage_nextBtnArrow": nuriPracticalApplication,
      "textStage_nextBtnShadow": pinkShadowTwo,

      "endPage_background": pinkThree,
      "endPage_decoration": purpleOne,
      "endPage_boxColor": pinkOne,
      "endPage_boxShadow": pinkShadow,
      "endPage_closeIconColor": pinkTwo,
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
