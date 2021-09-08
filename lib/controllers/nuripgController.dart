import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harang/models/nuri.dart';
import 'package:harang/services/api_provider.dart';

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
    codeCtl.text = '꾸러미 "유용한 함수들.nuri"\n동사 [목록]에 [변환]을 각각 적용하다:\n 만약 [목록] == {} 이라면 {} 아니라면\t목록(첫번째: 변환([목록]의 첫번째),\n\t\t나머지: ([목록]의 나머지)에 [변환]을 각각 적용하다)';
  }

  //누리를 컴파일하고 결과값 적용
  void compile() async {
    Nuri result = await nuriAPI.postReq(codeCtl.text, input: inputCtl.text);
    output?.value = result.output;
    output?.value.removeAllWhitespace;
    await Future.delayed(Duration(seconds: 1));
    isCompiling.value = false;
  }
}
