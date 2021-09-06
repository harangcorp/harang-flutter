import 'package:configurable_expansion_tile_null_safety/configurable_expansion_tile.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:harang/controllers/nuristudyController.dart';
import 'package:harang/screens/nuristudy/study_start.dart';
import 'package:harang/themes/color_theme.dart';
import 'package:harang/themes/text_theme.dart';
import 'package:get/get.dart';

// 단계별 학습하기 메인 페이지
class StudyMain extends GetView<NuriStudyController> {
  const StudyMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            FutureBuilder(
                future: controller.getChapterContent(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) { //데이터를 정상적으로 받았을때
                    return Column(
                      children: [
                        SizedBox(
                          height: _height * 0.07,
                        ),
                        Stack(
                            children: [
                              Positioned(
                                bottom: 0,
                                child: Container(
                                  height: 10,
                                  width: 220,
                                  color: nuriStudy,
                                ),
                              ),
                              Text(
                                "단계별 학습하기",
                                style: homeTitleStyle,
                              ),
                            ]
                        ),
                        SizedBox(
                          height: _height * 0.025,
                        ),
                        Text(
                          "차근차근 알려드립니다!\n당신도 곧 누리 마스터가 될 거예요 :)",
                          style: homeDescriptionStyle,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: _height * 0.025,
                        ),
                        SizedBox(
                          width:  _width,
                          height: _height * 0.758,
                          child: ListView.builder(
                            padding: const EdgeInsets.only(bottom: 32.0),
                            itemCount: 3,
                            itemBuilder: (context, chapterIndex) {
                              return ConfigurableExpansionTile(
                                header: studyLevelBox(_height, _width, chapterIndex),
                                children: [
                                  SizedBox(
                                    width: _width,
                                    height: ((_height * 0.05) * controller.chapterStageAmount[chapterIndex+1]) + _height * 0.01,
                                    child: ListView.builder(
                                        padding: const EdgeInsets.all(8),
                                        itemCount: controller.chapterStageAmount[chapterIndex+1],
                                        itemBuilder: (context, stageIndex) {
                                          String boxMode = "lock";
                                          if (controller.stageProgress[(chapterIndex+1).toString()][(stageIndex + 1).toString()] ?? false) {
                                            if (controller.stageProgress["requiredStage"] == "${chapterIndex+1}-${stageIndex + 1}") {
                                              boxMode = "nowLevel";
                                            } else {
                                              boxMode = "unlock";
                                            }
                                          }
                                          return Column(
                                            children: [
                                              SizedBox(height: _height * 0.01),
                                              GestureDetector(
                                                  onTap: () {
                                                    int chapterNum = chapterIndex+1;
                                                    int stageNum = stageIndex+1;
                                                    bool? isStageProgress = controller.stageProgress[chapterNum.toString()][stageNum.toString()];
                                                    if (controller.stageProgress[chapterNum.toString()][stageNum.toString()] ?? false) {
                                                      controller.chapter = chapterNum;
                                                      controller.stageNum = stageNum;
                                                      controller.stageName = controller.chapterContent[chapterNum][stageNum]["title"];
                                                      Get.to(StudyStart());
                                                    } else {
                                                      Fluttertoast.showToast(
                                                          msg: "스테이지가 잠겨있습니다. 열려있는 스테이지를 클릭해주세요.",
                                                          toastLength: Toast.LENGTH_SHORT,
                                                          gravity: ToastGravity.BOTTOM,
                                                          timeInSecForIosWeb: 1,
                                                          backgroundColor: Color(0xE6FFFFFF),
                                                          textColor: Colors.black,
                                                          fontSize: 16.0
                                                      );
                                                    }
                                                  },
                                                  child: stageBox(_height, _width, controller.chapterColor[chapterIndex+1], boxMode, controller.chapterContent[chapterIndex+1][stageIndex+1]["title"])
                                              ),
                                            ],
                                          );
                                        }
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        )
                      ],
                    );
                  } else if (snapshot.hasError) { //데이터를 정상적으로 불러오지 못했을 때
                    return Column(
                      children: [
                        Text("데이터를 정상적으로 불러오지 못했습니다. \n다시 시도해 주세요.")
                      ],
                    );
                  } else { //데이터를 불러오는 중
                    return CircularProgressIndicator();
                  }
                }
            ),
          ],
        ),
      ),
    );
  }

  Column studyLevelBox(double _height, double _width, int articleIndex) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 50.0, top: 9, bottom: 9),
        ),
        Container(
          height: _height * 0.22,
          width: _width * 0.866,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: articles[articleIndex]["color"],
                blurRadius: 7,
              )
            ],
            color: articles[articleIndex]["color"],
            borderRadius: BorderRadius.circular(30),
          ),
          child: Stack(
            children: [
              Positioned(
                  top: -15,
                  right: _width * 0.564,
                  child: Container(
                      margin: EdgeInsets.only(right: 40, top: 30),
                      width: 47,
                      height: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: articles[articleIndex]["levelBox_color"],
                      ),
                      child: Center(
                        child: Text(
                          "${articles[articleIndex]["level"]-1}단계",
                          style: stepStudy_levelText,
                          textAlign: TextAlign.center,
                        ),
                      ))),
              Positioned(
                  top: 10,
                  right: _width * 0.354,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white,
                          blurRadius: 3,
                        )
                      ],
                    ),
                  )),
              Positioned(
                top: 13,
                right: _width * 0.362,
                child: Image.asset(
                  articles[articleIndex]["image"],
                  height: 45,
                ),
              ),
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 40,
                      width: 40,
                    ),
                    Text(
                      articles[articleIndex]["title"],
                      style: articles[articleIndex]["title_textStyle"],
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: _height * 0.011,
                      width: _width * 0.85,
                    ),
                    Text(
                      articles[articleIndex]["description"],
                      style: articles[articleIndex]["description_textStyle"],
                      textAlign: TextAlign.center,
                    ),
                  ]),
            ],
          ),
        ),
      ],
    );
  }

  Container stageBox(double _height, double _width, String color, String boxMode, String stageName) { //boxMode: lock, unlock, nowLevel
    BoxDecoration boxDecoration = BoxDecoration();
    TextStyle stageNameStyle = TextStyle();
    SizedBox lockIconBox = SizedBox();
    Color playBtnColor = Colors.white;

    if (boxMode == "lock") {
      boxDecoration = BoxDecoration(
        color: gray,
        borderRadius: BorderRadius.circular(30),
      );
      stageNameStyle = stepStudy_startPage_lock_stageName;
      lockIconBox = SizedBox(
        child: Icon(
          Icons.lock,
          size: _width * 0.05,
          color: grayTwo,
        ),
      );
      playBtnColor = grayTwo;
    } else if (boxMode == "unlock") {
      boxDecoration = BoxDecoration(
        color: controller.colorMap[color]["stageBoxInList_background"],
        borderRadius: BorderRadius.circular(30),
      );
      stageNameStyle = controller.colorMap[color]["stageBoxInList_stageNameStyle"];
      playBtnColor = controller.colorMap[color]["stageBox"];
    } else if (boxMode == "nowLevel") {
      boxDecoration = BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: controller.colorMap[color]["stageBoxInList_shadow"],
              blurRadius: 4,
            )
          ],
          color: controller.colorMap[color]["stageBoxInList_background"],
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
              width: 2,
              color: controller.colorMap[color]["stageBoxInList_border"]
          )
      );
      stageNameStyle = controller.colorMap[color]["stageBoxInList_stageNameStyle"];
      playBtnColor = controller.colorMap[color]["stageBox"];
    }

    return Container(
        height: _height * 0.04,
        width: _width * 0.76,
        alignment: Alignment.center,
        decoration: boxDecoration,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  stageName,
                  style: stageNameStyle,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: _width * 0.04,
                ),
                lockIconBox
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: _width * 0.06,
                  height: _width * 0.06,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: playBtnColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white,
                        blurRadius: 3,
                      )
                    ],
                  ),
                  child: Icon(
                    Icons.play_arrow,
                    size: _width * 0.045,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: _width * 0.03,
                )
              ],
            ),
          ],
        )
    );
  }
}

final List<Map> articles = [
  {
    "title": "코딩의 세계",
    "title_textStyle": stepStudyTitleStyle_worldOfCoding,
    "description": "코딩의 세계 설명 아주 간략하게 한두 줄 정도로만\n바로 여기에 적어주세요",
    "description_textStyle": stepStudyDescriptionStyle_worldOfCoding,
    "level": 1,
    "levelBox_color": worldOfCoding,
    "image": "assets/images/world_of_coding.png",
    "color": mint,
  },
  {
    "title": "누리의 문법",
    "title_textStyle": stepStudyTitleStyle_nuriGrammar,
    "description": "누리의 문법 설명 아주 간략하게 한두 줄 정도로만\n바로 여기에 적어주세요",
    "description_textStyle": stepStudyDescriptionStyle_nuriGrammar,
    "level": 2,
    "levelBox_color": nuriGrammar,
    "image": "assets/images/nuri_grammar.png",
    "color": purpleThree,
  },
  {
    "title": "누리 실전 응용",
    "title_textStyle": stepStudyTitleStyle_nuriPracticalApplication,
    "description": "누리 실전 응용 설명 아주 간략하게 한두 줄 정도로만\n바로 여기에 적어주세요",
    "description_textStyle": stepStudyDescriptionStyle_nuriPracticalApplication,
    "level": 3,
    "levelBox_color": nuriPracticalApplication,
    "image": "assets/images/nuri_practical_application.png",
    "color": purpleOne,
  },
];
