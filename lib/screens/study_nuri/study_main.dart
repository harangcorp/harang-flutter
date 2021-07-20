import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:harang/themes/color_theme.dart';
import 'package:harang/themes/text_theme.dart';

// 단계별 학습하기 메인 페이지
class StudyMain extends StatefulWidget {
  const StudyMain({Key? key}) : super(key: key);

  @override
  _StudyMainState createState() => _StudyMainState();
}

class _StudyMainState extends State<StudyMain> {

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: Column (
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
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
            studyLevelBox(_height, _width, 0),
            studyLevelBox(_height, _width, 1),
            studyLevelBox(_height, _width, 2),
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
            width: _width * 0.87,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: articles[articleIndex]["color"],
                      blurRadius: 7,
                  )
                ],
                color: articles[articleIndex]["color"],
                borderRadius: BorderRadius.circular(30)
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
                            "Lv.${articles[articleIndex]["level"]}",
                            style: stepStudy_levelText,
                            textAlign: TextAlign.center,
                          ),
                        ))
                ),
                Positioned(
                    top: 10,
                    right: _width * 0.354,
                    child: Container (
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
                    )
                ),
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
                    ]
                ),
              ],
            ),
          ),
      ],
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