import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:harang/app/modules/home/home_page.dart';
import 'package:harang/app/modules/login/login_page.dart';

//로그인 상태 확인 페이지

class LoginCheck extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          if(!snapshot.hasData){
            return AnimatedSwitcher( duration: Duration(milliseconds: 500),child: LoginPage());
          }else{
            return AnimatedSwitcher(
              duration: Duration(milliseconds: 500),
              child: HomePage(),
            );
          }
        },
      ),
    );
  }
}
