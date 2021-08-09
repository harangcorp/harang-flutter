import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:get/get.dart';
import 'package:harang/controllers/authController.dart';
import 'package:harang/screens/auth/signup.dart';

import 'package:harang/themes/color_theme.dart';
import 'package:harang/themes/text_theme.dart';
import 'package:harang/widgets/login_top_images.dart';

class Login extends GetView<AuthController> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Hero(
              tag: "topImage",
              child: Login_top_images(height: _height, width: _width),
            ),
            Column(
              children: [
                Container(
                    height: _height * 0.1   ,
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
                      fontSize: 22,
                      color: Color(0xFF495057)),
                ),
                Text(
                  '[하랑]',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: Color(0xFFD59BF6)),
                ),  Text(
                  '하랑은 어린이 코딩 교육 플랫폼입니다.\n한글을 이용해 코딩을 재미있게 배워봐요!',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Color(0xFFD59BF6)),
                ),
              ],
            ),
            Container(
              height: 40,
              margin: EdgeInsets.only(left: 40, right: 40, top: 30),
              padding: EdgeInsets.only(right: 20, left: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [BoxShadow(color: purpleShadow, blurRadius: 10)]),
              child: TextField(
                cursorColor: purpleOne,
                maxLines: 1,
                controller: emailController,
                decoration: InputDecoration(
                  hintText: "아이디",
                  hintStyle: hintStyle,
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ),
            ),
            Container(
              height: 40,
              margin: EdgeInsets.only(left: 40, right: 40, top: 30),
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [BoxShadow(color: purpleShadow, blurRadius: 10)]),
              child: TextField(
                maxLines: 1,
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: "비밀번호",
                  hintStyle: hintStyle,
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ),
            ),
            Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                    onTap: () => controller.login(
                        emailController.text, passwordController.text),
                    child: Container(
                        margin: EdgeInsets.only(right: 40, top: 30),
                        width: 105,
                        height: 36,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Color(0xffD99FF6),
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xffE4CBFF),
                                  blurRadius: 10,
                                  spreadRadius: 3)
                            ]),
                        child: Center(
                          child: Text(
                            "로그인",
                            style: btnText,
                          ),
                        )))),
          ],
        ),
      ),
    );
  }
}
