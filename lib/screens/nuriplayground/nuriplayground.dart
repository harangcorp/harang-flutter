import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harang/controllers/nuripgController.dart';
import 'package:harang/controllers/nuristudyController.dart';
import 'package:harang/themes/color_theme.dart';
import 'package:harang/themes/text_theme.dart';

//누리 놀이터 페이지
class NuriPlayGround extends GetWidget<NuripgController> {
  const NuriPlayGround({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        child: Container(
                          height: 9,
                          width: 140,
                          color: mint,
                        ),
                      ),
                      Text(
                        "누리 놀이터",
                        style: np_title,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 48),
                codeWriteUI(context, controller, null, "mint", "nuriPlayground")
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column codeWriteUI(BuildContext context, NuripgController nuriPgController, NuriStudyController? nuriStudyController, String color, String uiMode) { //uiMode: nuriPlayground, stepStudy
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    Map colorMap = nuriPgController.colorMap;

    late double boxPadding;
    late double outputBoxHeight;
    late String compileBtnText;
    if (uiMode == "nuriPlayground") {
      boxPadding = 16;
      outputBoxHeight = height * 0.17;
      compileBtnText = "실행하기";
    } else {
      boxPadding = 10;
      outputBoxHeight = height * 0.13;
      compileBtnText = "채점하기";
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "코드",
                  style: colorMap[color]["codeBox_subTitleStyle"],
                ),

                Obx(() => nuriPgController.isCompiling.value
                    ? loadingButton(
                    colorMap[color]["compileBtn_background"],
                    colorMap[color]["compileBtn_border"],
                    colorMap[color]["loadingBtn_shadow"],
                    colorMap[color]["loadingBtn_progressIndicator"]
                )
                    : buildCompileButton(context, nuriPgController, nuriStudyController, uiMode, colorMap[color]["compileBtn_background"], compileBtnText, colorMap[color]["compileBtn_textStyle"], colorMap[color]["compileBtn_border"], colorMap[color]["compileBtn_startIconBackground"])),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: boxPadding),
              padding: EdgeInsets.symmetric(horizontal: boxPadding),
              height: height * 0.25,
              decoration: BoxDecoration(
                  color: colorMap[color]["codeBox_background"],
                  border: Border.all(color: colorMap[color]["codeBox_border"], width: 1),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(color: colorMap[color]["codeBox_shadow"], blurRadius: 8)
                  ]),
              child: TextField(
                controller: nuriPgController.codeCtl,
                keyboardType: TextInputType.multiline,
                maxLines: 15,
                style: codetext,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusColor: Colors.amber,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: boxPadding),
              child: Text(
                "입력",
                style: colorMap[color]["codeBox_subTitleStyle"],
              ),
            ),
            Container(
              padding: EdgeInsets.all(boxPadding),
              height: height * 0.07,
              decoration: BoxDecoration(
                  color: colorMap[color]["codeBox_background"],
                  border: Border.all(color: colorMap[color]["codeBox_border"], width: 1),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(color: colorMap[color]["codeBox_shadow"], blurRadius: 8)
                  ]),
              child: TextField(
                controller: nuriPgController.inputCtl,
                style: codetext,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusColor: Colors.amber,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: boxPadding),
              child: Text(
                "출력",
                style: colorMap[color]["codeBox_subTitleStyle"],
              ),
            ),
            Container(
                height: outputBoxHeight,
                width: width,
                padding: EdgeInsets.all(boxPadding),
                decoration: BoxDecoration(
                    color: colorMap[color]["codeBox_background"],
                    border: Border.all(color: colorMap[color]["codeBox_border"], width: 1),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(color: colorMap[color]["codeBox_shadow"], blurRadius: 8)
                    ]),
                child: Obx(() => SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    "${nuriPgController.output}",
                    style: codetext,
                  ),
                ))),
          ],
        ),
      ],
    );
  }

  Widget loadingButton(Color backgroundColor, Color borderColor, Color shadowColor, Color progressIndicatorColor) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: borderColor, width: 1),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: shadowColor, blurRadius: 8)]),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircularProgressIndicator(
          color: progressIndicatorColor,
        ),
      ),
    );
  }

  GestureDetector buildCompileButton(BuildContext context, NuripgController nuriPgController, NuriStudyController? nuriStudyController, String uiMode,
      Color backgroundColor, String btnText, TextStyle btnTextStyle, Color borderColor, Color startIconColor) {
    return GestureDetector(
      onTap: () {
        if (uiMode == "nuriPlayground") {
          nuriPgController.compile();
        } else {
          nuriStudyController!.checkCorrectCode(context, nuriPgController);
        }

        nuriPgController.isCompiling.value = true;
        hideKeyboard(context);
      },
      child: Hero(
        tag: "compilebutton",
        transitionOnUserGestures: true,
        child: Container(
          width: 120,
          height: 40,
          decoration: BoxDecoration(
              color: backgroundColor,
              border: Border.all(color: borderColor, width: 2),
              borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 5,
              ),
              Container(
                child: Icon(
                  Icons.play_circle,
                  color: startIconColor,
                  size: 30,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                btnText,
                style: btnTextStyle,
              )
            ],
          ),
        ),
      ),
    );
  }

  void hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}
