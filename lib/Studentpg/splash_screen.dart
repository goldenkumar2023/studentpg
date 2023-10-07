import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:studentpg/Studentpg/home_page.dart';
import 'buttonnavigation.dart';
import 'enter_number.dart';
import 'login_page.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
            () {
              isUserLoggedIn().then((value) {
            if(value){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ButtonNavigtionPage(),));
            }
            else{
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const PhoneNumber()));
            }
          });
            });
  }

  Future<bool> isUserLoggedIn() async {
    var user = FirebaseAuth.instance.currentUser?.uid;

    if (user != null) {

      return true;
    } else {
      return false;
    }
  }

  // @override
  // void dispose() {
  //   super.dispose();
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            Lottie.network('https://assets4.lottiefiles.com/private_files/lf30_kktybdlt.json'),
            const CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
