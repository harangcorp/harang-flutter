import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:harang/screens/study_nuri/chapters/studyui_template.dart';
import 'package:harang/themes/color_theme.dart';
import 'package:harang/themes/text_theme.dart';

import 'package:harang/screens/study_nuri/study_end.dart';

class Stage2_WhatIsProgramming extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    return StudyUiTemplate().chapter1UiTemplate(
      _height,
      _width,
      2,
      "프로그래밍이란?",
      StudyEnd(color: "mint", stageNum: 2, stageTitle: "프로그래밍이란?"),
      Column(
        children: [
          RichText(
              text: TextSpan(
                  text: "프로그래밍이란,\n",
                  style: stepStudy_studyPage_mint_contentDefault,
                  children: <TextSpan> [
                    TextSpan(
                      text: "컴퓨터 프로그램을 만드는 것",
                      style: stepStudy_studyPage_mint_contentBold,
                    ),
                    TextSpan(
                      text: "을 말해요.",
                      style: stepStudy_studyPage_mint_contentDefault,
                    )
                  ]
              )
          ),
          SizedBox(height: 20),
          RichText(
              text: TextSpan(
                  text: "그리고 프로그램이란,\n",
                  style: stepStudy_studyPage_mint_contentDefault,
                  children: <TextSpan> [
                    TextSpan(
                      text: "프로그래밍을 한 결과물",
                      style: stepStudy_studyPage_mint_contentBold,
                    ),
                    TextSpan(
                      text: "을 말하죠.",
                      style: stepStudy_studyPage_mint_contentDefault,
                    )
                  ]
              )
          ),
          SizedBox(height: 20),
          Text(
            "프로그래밍의 예시를 들자면, \n우리가 친구들이랑 대화할 때 쓰는 카카오톡이나, \n동영상을 재생해주는 유튜브를 만드는 것을 \n예시로 들 수 있어요.",
            style: stepStudy_studyPage_mint_contentDefault,
          ),
        ],
      ),
    );
  }
}
