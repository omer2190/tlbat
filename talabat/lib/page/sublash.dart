import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talabat/page/singinpage.dart';

import '../src/getxcot.dart';
import 'myhomepage.dart';

class Sublash extends StatefulWidget {
  const Sublash({Key? key}) : super(key: key);

  @override
  State<Sublash> createState() => _SublashState();
}

class _SublashState extends State<Sublash> {
  @override
  void initState() {
    super.initState();
    checkmy();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }

  void checkmy() {
    final GetxCot c = Get.put(GetxCot());
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        // GetxCot().myInfo(user.uid, user.displayName!, user.phoneNumber!, "");
        c.myInfo(user.uid, user.displayName!, user.phoneNumber!, "");
        // cot.myInfo(user.uid, user.displayName!, user.phoneNumber!, "");
        // Get.off(() => const Sublash());
        // Get.offAll(() => const Sublash());
        Get.to(() => const MyHomePage());
      } else {
        Get.to(() => const SingIn());
      }
    });
  }
}
