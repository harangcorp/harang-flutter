import 'package:flutter/material.dart';
import 'package:harang/themes/color_theme.dart';
import 'package:harang/themes/text_theme.dart';
import 'package:get/get.dart';

class StudyUiTemplate {
  Scaffold textStageTemplate(double _height, double _width, int stageNum, String stageName, dynamic nextWindow, Column educationContent) {
    return Scaffold (
        body: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                color: mintTwo,
                width: _width,
                height: _height,
              ),
              Positioned(
                top: 0,
                child: ClipPath(
                  clipper: bottomDesignPainter(),
                  child: Container(
                    height: _height * 0.875,
                    width: _width,
                    decoration: BoxDecoration(color: mint),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          top: _height * 0.05,
                          child: Container(
                            height: _height * 0.425,
                            width: _width * 0.75,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Color(0x66FFFFFF), width: 30),
                            ),
                          ),
                        ),
                        Positioned(
                          top: _height * 0.15,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  width: _width * 0.14,
                                  height: _height * 0.0325,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: mintThree,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "$stageNum/4",
                                      style: stepStudy_startPage_stageNum,
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                              ),
                              SizedBox(
                                height: _height * 0.0225,
                              ),
                              Text(
                                stageName,
                                style: stepStudy_studyPage_mint_title,
                              )
                            ],
                          ),
                        ),
                        Positioned(
                            top: _height * 0.26,
                            child: Container(
                              width: _width * 0.875,
                              height: _height * 0.525,
                              decoration: BoxDecoration(
                                color: mintTwo,
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                    color: mintThree_shadow,
                                    offset: Offset(-8, 20),
                                    blurRadius: 25,
                                  ),
                                ],
                              ),
                              child: Stack(
                                alignment: Alignment.topCenter,
                                children: [
                                  Positioned(
                                    top: _height * 0.02,
                                    child: educationContent,
                                  ),
                                  Positioned(
                                      top: _height * 0.415,
                                      left: _width * 0.65,
                                      child: GestureDetector(
                                        onTap: () => Get.to(nextWindow),
                                        child: Container(
                                          width: _width * 0.16,
                                          height: _width * 0.16,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: mintThree_shadow,
                                                offset: Offset(-4, 8),
                                                blurRadius: 10,
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                'assets/images/studyNuri/nextPageBtnArrow.png',
                                                color: mintThree,
                                                width: _width * 0.09,
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                  )
                                ],
                              ),
                            )
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                  bottom: -(_height * 0.02),
                  child: Image.asset(
                    'assets/images/studyNuri/chapter1_bottomBackground.png',
                    width: _width,
                  )
              ),
            ],
          ),
        )
    );
  }
}

class bottomDesignPainter extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    final double _xScaling = size.width / 386;
    final double _yScaling = size.height / 706;

    path.lineTo(91.5 * _xScaling,673.5 * _yScaling);
    path.cubicTo(65.7918 * _xScaling,675.088 * _yScaling,21.7135 * _xScaling,705.378 * _yScaling,5 * _xScaling,696.5 * _yScaling,);
    path.cubicTo(5 * _xScaling,696.5 * _yScaling,0 * _xScaling,696.5 * _yScaling,0 * _xScaling,696.5 * _yScaling,);
    path.cubicTo(0 * _xScaling,696.5 * _yScaling,0 * _xScaling,0.5 * _yScaling,0 * _xScaling,0.5 * _yScaling,);
    path.cubicTo(0 * _xScaling,0.5 * _yScaling,388 * _xScaling,0.5 * _yScaling,388 * _xScaling,0.5 * _yScaling,);
    path.cubicTo(388 * _xScaling,0.5 * _yScaling,396 * _xScaling,701 * _yScaling,396 * _xScaling,701 * _yScaling,);
    path.cubicTo(396 * _xScaling,701 * _yScaling,379.5 * _xScaling,701 * _yScaling,379.5 * _xScaling,701 * _yScaling,);
    path.cubicTo(379.5 * _xScaling,701 * _yScaling,369.5 * _xScaling,698.5 * _yScaling,369.5 * _xScaling,698.5 * _yScaling,);
    path.cubicTo(327.85 * _xScaling,673.133 * _yScaling,310.911 * _xScaling,665.289 * _yScaling,297 * _xScaling,667.5 * _yScaling,);
    path.cubicTo(285.895 * _xScaling,667.89 * _yScaling,257.5 * _xScaling,683.5 * _yScaling,246.5 * _xScaling,690 * _yScaling,);
    path.cubicTo(235.5 * _xScaling,696.5 * _yScaling,216.222 * _xScaling,706.347 * _yScaling,188 * _xScaling,705.5 * _yScaling,);
    path.cubicTo(155.489 * _xScaling,707.981 * _yScaling,117.208 * _xScaling,671.912 * _yScaling,91.5 * _xScaling,673.5 * _yScaling,);
    path.cubicTo(91.5 * _xScaling,673.5 * _yScaling,91.5 * _xScaling,673.5 * _yScaling,91.5 * _xScaling,673.5 * _yScaling,);

    return path;
  }
  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}