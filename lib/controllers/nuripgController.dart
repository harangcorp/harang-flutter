import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harang/models/nuri.dart';
import 'package:harang/services/api_provider.dart';
import 'package:rich_text_controller/rich_text_controller.dart';

class NuripgController extends GetxController {
  Rx<String>? output = ''.obs;
  Rx<bool> isCompiling = false.obs;
  NuriAPI nuriAPI = NuriAPI();
  late TextEditingController? codeCtl;
  late TextEditingController inputCtl;

  @override
  void onInit() {
    super.onInit();
    codeCtl = RichTextController(
      //   stringMap: {
      //     "aa": TextStyle(color: Colors.blue),
      //   },
      onMatch: (List<String?>? matches) {},
    );

    inputCtl = TextEditingController();
    codeCtl?.text = '꾸러미 "유용한 함수들.nuri"';
  }

  //누리를 컴파일하고 결과값 적용
  void compile() async {
    Nuri result =
        await nuriAPI.postReq(codeCtl?.text ?? "", input: inputCtl.text);
    output?.value = result.output;
    isCompiling.value = false;
  }
}