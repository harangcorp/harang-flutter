import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harang/models/nuri.dart';
import 'package:harang/services/api_provider.dart';
import 'package:harang/themes/color_theme.dart';
import 'package:harang/themes/text_theme.dart';
import 'nuriHighLighter.dart';

class NuripgController extends GetxController {
  Rx<String>? output = ''.obs;
  Rx<bool> isCompiling = false.obs;
  NuriAPI nuriAPI = NuriAPI();
  late TextEditingController codeCtl;
  late TextEditingController inputCtl;

  @override
  void onInit() {
    super.onInit();
    codeCtl = NuriHighLighter();

    inputCtl = TextEditingController();
    codeCtl.text = '꾸러미 "유용한 함수들.nuri"\n';
  }

  //누리를 컴파일하고 결과값 적용
  compile() async {
    Nuri result = await nuriAPI.postReq(codeCtl.text, input: inputCtl.text);
    output?.value = result.output;
    output?.value.removeAllWhitespace;
    await Future.delayed(Duration(seconds: 1));
    isCompiling.value = false;
  }

  final Map colorMap = {
    "mint": {
      "codeBox_background": Color(0xfff8FFFE),
      "codeBox_border": mint_shadow,
      "codeBox_shadow": mint_shadow.withOpacity(0.4),
      "codeBox_subTitleStyle": np_subtitle_mint,

      "loadingBtn_shadow": mint_shadow,
      "loadingBtn_progressIndicator": mint,
      "compileBtn_background": Colors.white,
      "compileBtn_border": mint,
      "compileBtn_startIconBackground": mint,
      "compileBtn_textStyle": np_btn_mint,
    },
    "purple": {
      "codeBox_background": purpleTen,
      "codeBox_border": emptyColor,
      "codeBox_shadow": purpleSeven_shadow2,
      "codeBox_subTitleStyle": np_subtitle_purple,

      "loadingBtn_shadow": purpleSeven_shadow2,
      "loadingBtn_progressIndicator": purpleEight,
      "compileBtn_background": purpleTen,
      "compileBtn_border": emptyColor,
      "compileBtn_startIconBackground": purpleEight,
      "compileBtn_textStyle": np_btn_purple,
    },
    "pink": {
      "codeBox_background": pinkOne,
      "codeBox_border": emptyColor,
      "codeBox_shadow": pinkShadowFour,
      "codeBox_subTitleStyle": np_subtitle_pink,

      "loadingBtn_shadow": pinkShadowFour,
      "loadingBtn_progressIndicator": pinkTwo,
      "compileBtn_background": pinkOne,
      "compileBtn_border": emptyColor,
      "compileBtn_startIconBackground": pinkTwo,
      "compileBtn_textStyle": np_btn_pink,
    },
  };
}
