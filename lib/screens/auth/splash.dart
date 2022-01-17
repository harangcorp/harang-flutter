import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:harang/controllers/authController.dart';
import 'package:harang/screens/auth/login.dart';
import 'package:harang/screens/auth/signup.dart';
import 'package:harang/themes/color_theme.dart';
import 'package:harang/themes/text_theme.dart';
import 'package:harang/widgets/login_top_images.dart';

class Splash extends GetWidget<AuthController> {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              child: Hero(
                tag: "topImage",
                child: Login_top_images(height: _height, width: _width),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    SizedBox(height: _height * 0.3),
                    Container(
                        height: _height * 0.1,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: new AssetImage('assets/images/logo.png'),
                          fit: BoxFit.fitHeight,
                        ))),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '한글이 만드는 코딩,',
                      style: TextStyle(
                        fontFamily: 'NotoSansKR',
                          fontWeight: FontWeight.w700,
                          fontSize: 22,
                          color: Color(0xFF495057)),
                    ), SizedBox(
                      height: 10,
                    ),
                    Text(
                      '하랑',
                      style: logoHarang,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      '하랑은 어린이 코딩 교육 플랫폼입니다.\n한글을 이용해 코딩을 재미있게 배워봐요!',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Color(0xFFD59BF6)),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () => Get.to(() => Login(),transition: Transition.noTransition),
                      child: Container(
                        width: _width * 0.55,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Color(0xFFD59BF6),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xffE4CBFF),
                                  blurRadius: 12,
                                  offset: Offset(0, 0)),
                            ]),
                        child: Center(
                          child: Text('로그인',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17,
                                  color: Colors.white)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    GestureDetector(
                      onTap: () => Get.to(() => Signup(),transition: Transition.noTransition),
                      child: Container(
                        width: _width * 0.55,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xffE4CBFF),
                                  blurRadius: 12,
                                  offset: Offset(0, 0)),
                            ]),
                        child: Center(
                          child: Text('회원가입',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17,
                                  color: Color(0xFFD59BF6))),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      color: purpleOne,
                      width: _width * 0.18,
                      height: 0.8,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "또는",
                        style: TextStyle(color: purpleOne, fontSize: 12),
                      ),
                    ),
                    Container(
                      color: purpleOne,
                      width: _width * 0.18,
                      height: 0.8,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => {controller.signInWithFacebook()},
                      child: Container(
                        margin: EdgeInsets.only(right: 8, bottom: 16),
                        padding: EdgeInsets.all(6),
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                            color: purpleOne,
                            borderRadius: BorderRadius.circular(17.5),
                            boxShadow: [
                              BoxShadow(
                                  color: purpleShadow,
                                  blurRadius: 10,
                                  spreadRadius: 1)
                            ]),
                        child: SvgPicture.asset(
                            'assets/images/facebookIcon.svg',
                            color: Colors.white),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => {controller.signInWithGoogle()},
                      child: Container(
                        margin: EdgeInsets.only(left: 8, bottom: 16),
                        padding: EdgeInsets.all(6),
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(17.5),
                            boxShadow: [
                              BoxShadow(
                                  color: purpleShadow,
                                  blurRadius: 10,
                                  spreadRadius: 1)
                            ]),
                        child: SvgPicture.asset(
                          'assets/images/googleIcon.svg',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Platform.isIOS ? controller.signInWithApple() : Get.snackbar('애플 로그인 오류', '현재 안드로이드 기기에서 \n애플 로그인은 지원되지 않습니다.', snackPosition: SnackPosition.BOTTOM),
                      child: Container(
                        margin: EdgeInsets.only(left: 16, bottom: 16),
                        padding: EdgeInsets.all(6),
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                            color: purpleOne,
                            borderRadius: BorderRadius.circular(17.5),
                            boxShadow: [
                              BoxShadow(
                                  color: purpleShadow,
                                  blurRadius: 10,
                                  spreadRadius: 1)
                            ]),
                        child: SvgPicture.asset(
                            'assets/images/appleIcon.svg',
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        style: appTerms,
                        text: "본 서비스에 회원가입 및 로그인을 진행할 시\n",
                      ),
                      TextSpan(
                        style: appTerms.copyWith(
                          color: Colors.lightBlueAccent,
                        ),
                        text: "개인정보처리약관",
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            String url = 'https://bit.ly/2XPgDq9';
                            _launchURL(url);
                          },
                      ),
                      TextSpan(
                        style: appTerms,
                        text: "과 ",
                      ),
                      TextSpan(
                        style: appTerms.copyWith(
                          color: Colors.lightBlueAccent,
                        ),
                        text: "이용약관",
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            String url = 'https://bit.ly/2XKO1OA';
                            _launchURL(url);
                          },
                      ),
                      TextSpan(
                        style: appTerms,
                        text: "에 동의하는 것으로 간주합니다.",
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                  style: appTerms,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _launchURL(String _url) async =>
      await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
}
