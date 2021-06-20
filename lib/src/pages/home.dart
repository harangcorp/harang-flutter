import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:harang/src/pages/login.dart';

//로그인 상태 확인 페이지

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          if(!snapshot.hasData){
            return LoginPage();
          }else{
            return Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("success login\nHello ~ ${snapshot.data.displayName}"),
                ElevatedButton(onPressed: FirebaseAuth.instance.signOut ,child: Text("Log out"),)
              ],
            ));
          }
        },
      ),
    );
  }
}
