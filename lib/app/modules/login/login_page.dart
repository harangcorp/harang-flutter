import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_svg/svg.dart';
import 'local_widgets/gradient.dart';
import 'local_widgets/login_painter.dart';

class LoginPage extends StatelessWidget {
  Future<UserCredential> _signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
    await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipPath(
              clipper: Painter(),
              child: Container(
                height: _height * 0.35,
                width: _width,
                decoration: BoxDecoration(
                    gradient: buildLinearGradient()),
                child: Stack(
                  children: [
                    Align(
                      child: Image.asset(
                        'assets/images/login_man.png',
                        width: _width * 0.85,
                      ),
                      alignment: Alignment.bottomCenter,
                    ),
                    Positioned(
                        top: 10,
                        right: _width * 0.2,
                        child: Image.asset(
                          'assets/images/cloud.png',
                          height: 60,
                        )),
                    Positioned(
                        top: 40,
                        right: _width * 0.65,
                        child: Image.asset(
                          'assets/images/cloud.png',
                          height: 50,
                        )),
                    Positioned(
                        top: 80,
                        left: -10,
                        child: Image.asset(
                          'assets/images/cloud.png',
                          height: 70,
                        )),
                    Positioned(
                        bottom: 100,
                        right: _width * 0.03,
                        child: Image.asset(
                          'assets/images/cloud.png',
                          height: 50,
                        ))
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Container(
                      height: _height * 0.12,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: new AssetImage('assets/images/logo.png'),
                            fit: BoxFit.fitHeight,
                          ))),
                  SizedBox(height: 20,),
                  Text(
                    '한글이 만드는 코딩',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                        color: Color(0xFF495057)),
                  ),
                  Text('[하랑]',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                        color: Color(0xFFD59BF6)),),  SizedBox(height: 15,),
                  Text(
                    '하랑은 어린이 코딩 교육 플랫폼입니다.\n한글을 이용해 코딩을 재미있게 배워봐요!',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        color: Color(0xFFD59BF6)),
                  ),

                ],
              ),
            ),
            Expanded( flex: 2,
              child: Column(

                children: [

                  GestureDetector(
                    onTap: (){},
                    child: Container(
                      width: _width * 0.6,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Color(0xFFD59BF6),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [BoxShadow(color: Color(0xffE4CBFF), blurRadius: 10,spreadRadius: 3,offset: Offset(0,0) ),]
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/images/kakaoIcon.svg',
                            height: 20,
                          ),
                          SizedBox(width: 10,),
                          Text('Kakao 계정으로 로그인', style: TextStyle(fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  GestureDetector(
                    onTap: _signInWithGoogle,
                    child: Container(
                      width: _width * 0.6,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [BoxShadow(color: Color(0xffE4CBFF), blurRadius: 10,spreadRadius: 3,offset: Offset(0,0) ),]
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/images/googleIcon.svg',
                            height: 20,
                          ),
                          SizedBox(width: 10,),
                          Text('Google 계정으로 로그인', style: TextStyle(fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: Color(0xFFD59BF6))),
                        ],
                      ),
                    ),
                  )
                ],),
            ),
            Column(
              children: [

                Text("COPYRIGHT ⓒ 2021. ICELUNA. All rights reserved.", style: TextStyle(fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: Color(0xff868E96))),
                SizedBox(height: 20,)
              ],
            )

          ],
        ),
      ),
    );
  }
}
