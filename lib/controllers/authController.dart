import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:harang/controllers/userController.dart';
import 'package:harang/models/user.dart';
import 'package:harang/screens/require_permission.dart';
import 'package:harang/services/database.dart';
import 'package:harang/utils/root.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Rxn<User> _firebaseUser = Rxn<User>();

  User? get user => _firebaseUser.value;

  late bool isFirstOpen;
  late SharedPreferences sharedPreferences;

  @override
  onInit() {
    _firebaseUser.bindStream(_auth.authStateChanges());

    checkFirstOpenPermissionPage();
  }

  void createUser(
      String name, String email, String password, String passwordCheck) async {
    try {
      if (password != passwordCheck) throw Exception('비밀번호가 일치하지 않습니다.');
      UserCredential _authResult = await _auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password);

      writeAccountInfo(_authResult.user?.uid, _authResult.user?.email, name, true);
      openPermissionPage();
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "회원가입 오류",
        e.message ?? "예기치 못한 오류가 발생하였습니다.",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void login(String email, String password) async {
    try {
      UserCredential _authResult = await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password);
      Get.find<UserController>().user =
          await Database().getUser(_authResult.user?.uid);
      Get.offAll(Root(),transition: Transition.rightToLeft);
      openPermissionPage();
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "로그인 오류",
        e.message ?? "예기치 못한 오류가 발생하였습니다.",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void signOut() async {
    try {
      await _auth.signOut();

      checkFirstOpenPermissionPage();

      Get.find<UserController>().clear();
      Get.offAll(Root(), transition: Transition.leftToRight);
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "로그아웃 오류",
        e.message ?? "예기치 못한 오류가 발생하였습니다.",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    UserCredential _authResult = await FirebaseAuth.instance.signInWithCredential(credential);

    writeAccountInfo(_authResult.user?.uid, googleUser?.email, googleUser?.displayName, false);

    openPermissionPage();

  }

  void signInWithFacebook() async {
    //TODO iOS 부분 페이스북 로그인은 맥북이 없으므로 작성하지 않았음, 추후 iOS 배포할 시 관련 작업 필요.

    try {
      final facebookLoginResult = await FacebookAuth.instance.login();
      final userData = await FacebookAuth.instance.getUserData();

      final facebookAuthCredential = FacebookAuthProvider.credential(
          facebookLoginResult.accessToken!.token);
      UserCredential _authResult = await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);

      writeAccountInfo(_authResult.user?.uid, userData['email'], userData['name'], false);

      openPermissionPage();
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'account-exists-with-different-credential':
          print("This account exists with a different sign in provider");
          break;
      }
    }
  }

  void writeAccountInfo(String? userID, String? email, String? name, bool isEmailSignUp) async {
    UserModel _user = UserModel(
        id: userID,
        email: email,
        name: name,
        score: 0,
        stageProgress: {
          "requiredStage": "1-1",
          "1": {
            "1": true,
            "2": false,
          },
          "2": {
            "1": false,
          },
          "3": {
            "1": false,
          }
        }
    );

    if (isEmailSignUp) {
      if (await Database().createNewUser(_user)) {
        Get.find<UserController>().user = _user;
      }
    } else {
      FirebaseFirestore.instance
          .collection("users")
          .doc(userID)
          .get()
          .then((doc) async {
        if (doc.exists) {
          print("exists");
        } else {
          if (await Database().createNewUser(_user)) {
            Get.find<UserController>().user = _user;
          }
        }
      }
      );
    }
  }

  checkFirstOpenPermissionPage() async {
    sharedPreferences = await SharedPreferences.getInstance();

    bool isFirstOpen = sharedPreferences.getBool('isFirstOpen') ?? true;

    this.isFirstOpen = isFirstOpen;
  }

  openPermissionPage() async {
    if (isFirstOpen) {
      Get.to(RequirePermission());
      await sharedPreferences.setBool('isFirstOpen', false);
    }
  }
}
