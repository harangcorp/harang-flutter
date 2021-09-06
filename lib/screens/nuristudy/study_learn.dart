import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harang/controllers/nuristudyController.dart';
import 'package:harang/screens/nuristudy/study_end.dart';
import 'package:harang/themes/text_theme.dart';

import 'studyui_template.dart';

class StudyLearn extends GetView<NuriStudyController> {

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    int chapterNum = controller.chapter;
    int stageNum = controller.stageNum;
    String stageName = controller.stageName;

    return StudyUiTemplate().textStageTemplate(
      _height,
      _width,
      stageNum,
      stageName,
      StudyEnd(),
      Column(
        children: [
          Text(
            (controller.chapterContent[chapterNum][stageNum]["contents"][stageNum.toString()]["content"] as String).replaceAll("\\n", "\n"),
            style: stepStudy_studyPage_mint_contentDefault,
          ),
        ],
      ),
    );
  }
}