import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_svg/svg.dart';

class LoginPage extends StatelessWidget {

  Future<UserCredential> _signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

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
            Container(
              height: _height * 0.3,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment(1,1.2), // 10% of the width, so there are ten blinds.
                  stops: [0.1, 0.2, 0.4, 0.6, 0.8, 2],
                  colors: const <Color>[Color(0xff9896F1), Color(0xffBE99F4),Color(0xffD59BF6),Color(0xffE2A7F3),Color(0xffEDB1F1),Color(0xffEDD5EF)], // red to yellow
                  tileMode: TileMode.decal, // repeats the gradient over the canvas
                )
              ),
              child: Stack(
                children: [
                  Positioned(
                      child: Image.asset('assets/images/login_man.png', width: _width* 0.8,)
                    ,bottom: 0,
                    right: _width*0.1,
                  ),
                  Positioned(
                      top: 10,
                      right: _width * 0.2,
                      child: Image.asset('assets/images/cloud.png',height: 60,)),
                  Positioned(
                      top: 20,
                      right: _width * 0.7,
                      child: Image.asset('assets/images/cloud.png',height: 50,)),
                  Positioned(
                      top: 80,
                      left: -10,
                      child: Image.asset('assets/images/cloud.png',height: 70,)),
                  Positioned(
                      bottom: 50,
                      right: _width * 0.05,
                      child: Image.asset('assets/images/cloud.png',height: 50,))
                ],
              ),
              
            ),
            Image.asset('assets/images/logo.png', height: _height * 0.1,),
            Text('한글이 만드는 코딩'),
            Text('하랑'),
            Text('하랑은 어린이 코딩 교육 플랫폼입니다.\n한글을 이용해 코딩을 재미있게 배워봐요!'),
            ElevatedButton.icon(onPressed: (){}, icon: SvgPicture.asset('assets/images/kakaoIcon.svg', height: 20,), label: Text('Kakao 계정으로 로그인'),),
            ElevatedButton.icon(onPressed: _signInWithGoogle, icon: SvgPicture.asset('assets/images/googleIcon.svg', height: 20,), label: Text('Google 계정으로 로그인'),),
            Text("COPYRIGHT ⓒ 2021. ICELUNA. All rights reserved.")
          ],
        ),
      ),
    );
  }
}
