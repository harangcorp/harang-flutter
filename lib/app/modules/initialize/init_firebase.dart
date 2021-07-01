import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'login_check.dart';

// Firebase 시작 페이지

class InitFirebase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot){
      if(snapshot.hasError){
        return Center(child: Text("Error"),); // 오류 검출
      }
      if (snapshot.connectionState == ConnectionState.done){
        return LoginCheck();
      }
      return CircularProgressIndicator(); // 로딩
    });
  }
}
