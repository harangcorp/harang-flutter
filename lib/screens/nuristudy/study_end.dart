import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:harang/controllers/nuristudyController.dart';
import 'package:harang/screens/nuristudy/study_main.dart';
import 'package:harang/themes/text_theme.dart';
import 'package:get/get.dart';

import 'package:harang/screens/nuristudy/study_start.dart';

class StudyEnd extends GetView<NuriStudyController> {

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    int chapterNum = controller.chapter;
    int stageNum = controller.stageNum;
    String stageTitle = controller.stageName;
    String color = controller.chapterColor[chapterNum];

    return Scaffold(
      body: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                color: controller.colorMap[color]["endPage_decoration"],
                width: _width,
                height: _height,
              ),
              ClipPath(
                clipper: backgroundPainter(),
                child: Container(
                  height: _height,
                  width: _width,
                  decoration: BoxDecoration(color: controller.colorMap[color]["endPage_background"]),
                ),
              ),
              Container(
                  height: _height * 0.475,
                  width: _width * 0.88,
                  decoration: BoxDecoration(
                    color: controller.colorMap[color]["endPage_boxColor"],
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: controller.colorMap[color]["endPage_boxShadow"],
                        offset: Offset(-8, 20),
                        blurRadius: 30,
                      )
                    ],
                  ),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Positioned(
                        top: _height * 0.022,
                        right: _height * 0.022,
                        child: GestureDetector(
                          onTap: () => Get.off(StudyMain()),
                          child: Icon(
                            Icons.close_rounded,
                            color: controller.colorMap[color]["endPage_closeIconColor"],
                            size: _width * 0.07,
                          ),
                        )
                      ),
                      Positioned(
                        top: _height * 0.308,
                        left: _width * 0.415,
                        child: Text(
                          "결과",
                          style: controller.colorMap[color]["endPage_resultTextStyle"],
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Column(
                        children: [
                          SizedBox(height: _height * 0.035),
                          Container(
                              width: _width * 0.14,
                              height: _height * 0.0325,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: controller.colorMap[color]["stageBox"],
                              ),
                              child: Center(
                                child: Text(
                                  "$stageNum/4",
                                  style: stepStudy_startPage_stageNum,
                                  textAlign: TextAlign.center,
                                ),
                              )
                          ),
                          SizedBox(height: _height * 0.015),
                          Text(
                            stageTitle,
                            style: controller.colorMap[color]["endPage_titleStyle"],
                          ),
                          SizedBox(height: _height * 0.02),
                          Image.asset(
                            controller.colorMap[color]["endPage_finishIconImg"],
                            width: _width * 0.237,
                          ),
                          SizedBox(height: _height * 0.005),
                          Text(
                            "학습을 완료했어요!",
                            style: controller.colorMap[color]["endPage_congratsTextStyle"],
                          ),
                          SizedBox(height: _height * 0.02),
                          Image.asset(
                            "assets/images/studyNuri/endPage_textDecoration.png",
                            color: controller.colorMap[color]["endPage_textDecorationColor"],
                            width: _width * 0.725,
                          ),
                          SizedBox(height: _height * 0.025),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: _width * 0.12,
                                height: _width * 0.12,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: controller.colorMap[color]["endPage_pointCircle"]
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      "assets/images/studyNuri/endPage_pointStar.svg",
                                      fit: BoxFit.contain,
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: _width * 0.025,
                              ),
                              Text(
                                "+${controller.finalProvisionPoint}",
                                style: controller.colorMap[color]["endPage_pointTextStyle"],
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  )
              ),
            ],
          )
      ),
    );
  }
}

class backgroundPainter extends CustomClipper<Path> {

  @override
  Path getClip(Size size) {
    Path path = Path();

    final double _xScaling = size.width / 375;
    final double _yScaling = size.height / 812;

    path.lineTo(0 * _xScaling,334 * _yScaling);
    path.cubicTo(0 * _xScaling,334 * _yScaling,-0.5 * _xScaling,0 * _yScaling,-0.5 * _xScaling,0 * _yScaling,);
    path.cubicTo(-0.5 * _xScaling,0 * _yScaling,-0.5 * _xScaling,-2 * _yScaling,-0.5 * _xScaling,-2 * _yScaling,);
    path.cubicTo(-0.5 * _xScaling,-2 * _yScaling,157 * _xScaling,-1.5 * _yScaling,157 * _xScaling,-1.5 * _yScaling,);
    path.cubicTo(157 * _xScaling,-1.5 * _yScaling,157 * _xScaling,0 * _yScaling,157 * _xScaling,0 * _yScaling,);
    path.cubicTo(141.992 * _xScaling,12.7522 * _yScaling,132.982 * _xScaling,24.1002 * _yScaling,127.768 * _xScaling,35.2371 * _yScaling,);
    path.cubicTo(120.058 * _xScaling,47.8364 * _yScaling,116.441 * _xScaling,59.8203 * _yScaling,113.5 * _xScaling,75.5 * _yScaling,);
    path.cubicTo(111.581 * _xScaling,89.6221 * _yScaling,112.338 * _xScaling,102.876 * _yScaling,116.5 * _xScaling,115 * _yScaling,);
    path.cubicTo(124.855 * _xScaling,141.684 * _yScaling,145.315 * _xScaling,163.105 * _yScaling,169.796 * _xScaling,176.614 * _yScaling,);
    path.cubicTo(181.115 * _xScaling,183.285 * _yScaling,194.571 * _xScaling,187.743 * _yScaling,211 * _xScaling,191 * _yScaling,);
    path.cubicTo(227.932 * _xScaling,192.547 * _yScaling,246.933 * _xScaling,193.784 * _yScaling,260 * _xScaling,192.5 * _yScaling,);
    path.cubicTo(282.532 * _xScaling,192.78 * _yScaling,295.861 * _xScaling,192.799 * _yScaling,311.5 * _xScaling,200 * _yScaling,);
    path.cubicTo(312.75 * _xScaling,200.576 * _yScaling,320.238 * _xScaling,204.402 * _yScaling,329 * _xScaling,215 * _yScaling,);
    path.cubicTo(336.1 * _xScaling,222.468 * _yScaling,341.466 * _xScaling,231.485 * _yScaling,348.787 * _xScaling,237.611 * _yScaling,);
    path.cubicTo(356.568 * _xScaling,244.122 * _yScaling,365.155 * _xScaling,250.194 * _yScaling,376 * _xScaling,256.5 * _yScaling,);
    path.cubicTo(376 * _xScaling,256.5 * _yScaling,376 * _xScaling,634 * _yScaling,376 * _xScaling,634 * _yScaling,);
    path.cubicTo(368.842 * _xScaling,634.187 * _yScaling,364.885 * _xScaling,634.542 * _yScaling,358 * _xScaling,636.5 * _yScaling,);
    path.cubicTo(347.28 * _xScaling,640.024 * _yScaling,342.422 * _xScaling,642.778 * _yScaling,336 * _xScaling,649.5 * _yScaling,);
    path.cubicTo(326.279 * _xScaling,662.733 * _yScaling,319.075 * _xScaling,674.256 * _yScaling,313.5 * _xScaling,684 * _yScaling,);
    path.cubicTo(303.734 * _xScaling,698.878 * _yScaling,296.887 * _xScaling,708.827 * _yScaling,291.5 * _xScaling,712.5 * _yScaling,);
    path.cubicTo(283.9 * _xScaling,717.433 * _yScaling,276.368 * _xScaling,720.765 * _yScaling,261 * _xScaling,725 * _yScaling,);
    path.cubicTo(246.387 * _xScaling,729.445 * _yScaling,235.01 * _xScaling,734.019 * _yScaling,226 * _xScaling,737 * _yScaling,);
    path.cubicTo(212.973 * _xScaling,741.466 * _yScaling,204.86 * _xScaling,744.511 * _yScaling,199 * _xScaling,749 * _yScaling,);
    path.cubicTo(176.189 * _xScaling,769.205 * _yScaling,168.405 * _xScaling,784.145 * _yScaling,156.5 * _xScaling,812 * _yScaling,);
    path.cubicTo(156.5 * _xScaling,812 * _yScaling,0 * _xScaling,812 * _yScaling,0 * _xScaling,812 * _yScaling,);
    path.cubicTo(0 * _xScaling,812 * _yScaling,0 * _xScaling,662 * _yScaling,0 * _xScaling,662 * _yScaling,);
    path.cubicTo(23.6469 * _xScaling,653.762 * _yScaling,42.0305 * _xScaling,644.931 * _yScaling,58.5 * _xScaling,633 * _yScaling,);
    path.cubicTo(89.071 * _xScaling,609.265 * _yScaling,109.301 * _xScaling,585.504 * _yScaling,112 * _xScaling,560 * _yScaling,);
    path.cubicTo(110.452 * _xScaling,542.151 * _yScaling,106.8 * _xScaling,529.696 * _yScaling,100.5 * _xScaling,518 * _yScaling,);
    path.cubicTo(96.1775 * _xScaling,509.975 * _yScaling,90.9166 * _xScaling,502.308 * _yScaling,83 * _xScaling,493.5 * _yScaling,);
    path.cubicTo(78.9685 * _xScaling,489.199 * _yScaling,75.4167 * _xScaling,485.924 * _yScaling,71.5996 * _xScaling,483.242 * _yScaling,);
    path.cubicTo(66.1751 * _xScaling,478.629 * _yScaling,61.0012 * _xScaling,474.597 * _yScaling,54 * _xScaling,469 * _yScaling,);
    path.cubicTo(38.7545 * _xScaling,451.436 * _yScaling,35.7906 * _xScaling,439.448 * _yScaling,34.5 * _xScaling,416 * _yScaling,);
    path.cubicTo(34.9641 * _xScaling,401.52 * _yScaling,34.7585 * _xScaling,393.41 * _yScaling,36.5 * _xScaling,379 * _yScaling,);
    path.cubicTo(36.6328 * _xScaling,373.742 * _yScaling,34.5654 * _xScaling,369.273 * _yScaling,33 * _xScaling,366.5 * _yScaling,);
    path.cubicTo(25.6146 * _xScaling,357.093 * _yScaling,20.3193 * _xScaling,353.09 * _yScaling,15 * _xScaling,350 * _yScaling,);
    path.cubicTo(9.68066 * _xScaling,346.91 * _yScaling,8.6523 * _xScaling,346.049 * _yScaling,0 * _xScaling,342 * _yScaling,);
    path.cubicTo(0 * _xScaling,342 * _yScaling,0 * _xScaling,334 * _yScaling,0 * _xScaling,334 * _yScaling,);
    path.cubicTo(0 * _xScaling,334 * _yScaling,0 * _xScaling,334 * _yScaling,0 * _xScaling,334 * _yScaling,);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}