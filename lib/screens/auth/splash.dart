import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:harang/controllers/authController.dart';
import 'package:harang/screens/auth/login.dart';
import 'package:harang/screens/auth/signup.dart';
import 'package:harang/themes/color_theme.dart';
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
                child: Login_top_images(height: _height, width: _width)),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    SizedBox(height: _height * 0.3),
                    Container(
                        height: _height * 0.12,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: new AssetImage('assets/images/logo.png'),
                          fit: BoxFit.fitHeight,
                        ))),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      '한글이 만드는 코딩',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                          color: Color(0xFF495057)),
                    ),
                    Text(
                      '[하랑]',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                          color: Color(0xFFD59BF6)),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      '하랑은 어린이 코딩 교육 플랫폼입니다.\n한글을 이용해 코딩을 재미있게 배워봐요!',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          color: Color(0xFFD59BF6)),
                    ),
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () => Get.to(() => Login()),
                      child: Container(
                        width: _width * 0.6,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Color(0xFFD59BF6),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xffE4CBFF),
                                  blurRadius: 10,
                                  spreadRadius: 3,
                                  offset: Offset(0, 0)),
                            ]),
                        child: Center(
                          child: Text('로그인',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  color: Colors.white)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () => Get.to(() => Signup()),
                      child: Container(
                        width: _width * 0.6,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xffE4CBFF),
                                  blurRadius: 10,
                                  spreadRadius: 3,
                                  offset: Offset(0, 0)),
                            ]),
                        child: Center(
                          child: Text('회원가입',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
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
                      onTap: () => {controller.signInWithApple()},
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
                                  spreadRadius: 3)
                            ]),
                        child: SvgPicture.asset('assets/images/googleIcon.svg',
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
                                  spreadRadius: 3)
                            ]),
                        child: SvgPicture.asset(
                          'assets/images/googleIcon.svg',
                          fit: BoxFit.contain,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
