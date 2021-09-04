import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:harang/screens/study_nuri/chapters/studyui_template.dart';
import 'package:harang/themes/color_theme.dart';
import 'package:harang/themes/text_theme.dart';

import 'package:harang/screens/study_nuri/study_end.dart';

class Stage1_WorldOfZeroAndOne extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    return StudyUiTemplate().chapter1UiTemplate(
      _height,
      _width,
      1,
      "0과 1로 이루어진 세상",
      StudyEnd(color: "mint", stageNum: 1, stageTitle: "0과 1로 이루어진 세상"),
      Column(
        children: [
          RichText(
              text: TextSpan(
                  text: "그런데, 이 즐거운 휴대폰 속 세상들이 사실은\n모두 ",
                  style: stepStudy_studyPage_mint_contentDefault,
                  children: <TextSpan> [
                    TextSpan(
                      text: "0과 1로 이루어져있다는 것",
                      style: stepStudy_studyPage_mint_contentBold,
                    ),
                    TextSpan(
                      text: "을 아시나요?",
                      style: stepStudy_studyPage_mint_contentDefault,
                    )
                  ]
              )
          ),
          SizedBox(height: 20),
          Text(
            "우리가 마냥 재미없어 하는 수학으로,\n오히려 우리가 좋아하는 것들이 만들어지는거죠.\n어때요. 놀랍지 않나요?",
            style: stepStudy_studyPage_mint_contentDefault,
          ),
          SizedBox(height: 20),
          Text(
            "자, 그렇다면 지금부터",
            style: stepStudy_studyPage_mint_contentDefault,
          ),
          SizedBox(height: 10),
          Text(
            "0과 1로 이루어진 세상 속으로\n여러분들을 초대합니다!",
            style: stepStudy_studyPage_mint_contentExtraBold,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
