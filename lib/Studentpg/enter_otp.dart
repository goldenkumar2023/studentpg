import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studentpg/Studentpg/user_details.dart';

import '../user_exists.dart';
import 'buttonnavigation.dart';
import 'enter_number.dart';

class MyVerify extends StatefulWidget {
  var phoneNumber;

  MyVerify({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<MyVerify> createState() => _MyVerifyState();
}

class _MyVerifyState extends State<MyVerify> {

  TextEditingController pinController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;

  int? number;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future getData() async {
    var Shareprfe = await SharedPreferences.getInstance();
    setState(() {
      number = Shareprfe.getInt('number')!;
    });
  }

  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 25,
              ),
              const Text(
                "Phone Verification",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "We need to register your phone without getting started!",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),

              Pinput(
                animationCurve: Curves.bounceIn,
                keyboardType: TextInputType.text,
                controller: pinController,
                length: 6,
                showCursor: true,
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                textInputAction: TextInputAction.next,
              ),

              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.green.shade600,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () async {
                      try {
                        PhoneAuthCredential credential =
                            PhoneAuthProvider.credential(
                                verificationId: PhoneNumber.verify,
                                smsCode: pinController.text);
                        await auth.signInWithCredential(credential);

                        // Sign the user in (or link) with the credential
                        await auth.signInWithCredential(credential);
                        var uId = FirebaseAuth.instance.currentUser?.uid;
                        bool userExists = await checkUserExists(uId!);
                        if (userExists) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ButtonNavigtionPage(),
                              ));
                        } else {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterUserSection(),
                              ));
                        }

                        // ignore: use_build_context_synchronously

                        Fluttertoast.showToast(msg: "Login successful");
                      } catch (e) {
                        Fluttertoast.showToast(msg: "Enter Valid OTP");
                      }
                    },
                    child: const Text("Verify Phone Number")),
              ),
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RegisterUserSection()));
                      },
                      child: const Text(
                        "Edit Phone Number ?",
                        style: TextStyle(color: Colors.black),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
