import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harang/controllers/authController.dart';
import 'package:harang/themes/color_theme.dart';
import 'package:harang/themes/text_theme.dart';
import 'package:harang/widgets/login_top_images.dart';

class Signup extends GetView<AuthController> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordCheckController = TextEditingController();

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
              child: Login_top_images(height: _height * 0.8, width: _width),
            ),
            Container(
                height: _height * 0.1,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: new AssetImage('assets/images/logo.png'),
                  fit: BoxFit.fitHeight,
                ))),
            textFormBox(nameController, "이름"),
            textFormBox(emailController, "이메일"),
            textFormBox(passwordController, "비밀번호", true),
            textFormBox(passwordCheckController, "비밀번호 확인",true),
            Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                    onTap: () => controller.createUser(
                        nameController.text,
                        emailController.text,
                        passwordController.text,
                        passwordCheckController.text),
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
                            "회원가입",
                            style: btnText,
                          ),
                        ))))
          ],
        ),
      ),
    );
  }

  Column textFormBox(TextEditingController tc, String title, [ispwd = false]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 50.0, top: 20, bottom: 5),
          child: Text(
            "${title}",
            style: signuptext,
          ),
        ),
        Container(
          height: 40,
          margin: EdgeInsets.only(left: 40, right: 40),
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [BoxShadow(color: purpleShadow, blurRadius: 10)]),
          child: TextField(
            obscureText: ispwd,
            controller: tc,
            style: TextStyle(color: pinkFour),
            decoration: InputDecoration(
              hintText: "${title}을(를) 입력해주세요.",
              hintStyle: signuphintStyle,
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
    );
  }
}
