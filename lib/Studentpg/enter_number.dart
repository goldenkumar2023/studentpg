

import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'enter_otp.dart';


class PhoneNumber extends StatefulWidget {
  const PhoneNumber({Key? key}) : super(key: key);

  static String verify = "";

  @override
  State<PhoneNumber> createState() => _PhoneNumberState();
}

class _PhoneNumberState extends State<PhoneNumber> {

  TextEditingController phoneController=TextEditingController();

  final TextEditingController numbercontroller= TextEditingController();

  storeNumber() async{
  setState(() async {
    final prefs = await SharedPreferences.getInstance();
    // int numberValue= int.tryParse(numbercontroller.text)??0;
    prefs.setString('number', numbercontroller.text.toString() );

  });
  }



  userdata() {
    var auth = FirebaseAuth.instance.currentUser?.uid;
    FirebaseFirestore.instance.collection("users").doc(auth).set({
      "phone": phoneController.text.toString(),
    }).then((value) {

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(30),
            child: TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              maxLength: 10,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  labelText: "Enter your Phone Number"
              ),
            ),
          ),

          ElevatedButton(
              onPressed: () async {
                try {
                  await FirebaseAuth.instance.verifyPhoneNumber(
                    phoneNumber: '+91${phoneController.text}',
                    verificationCompleted: (PhoneAuthCredential credential) {},
                    verificationFailed: (FirebaseAuthException e) {},
                    codeSent: (String verificationId, int? resendToken) {
                      PhoneNumber.verify=verificationId;

                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>   MyVerify(phoneNumber:phoneController.text),));
                      Fluttertoast.showToast(msg: "Sent OTP");
                    },
                    codeAutoRetrievalTimeout: (String verificationId) {},
                  );
                  userdata();
                  storeNumber();
                }
                catch(e){
                  Fluttertoast.showToast(msg: "OTP Failed");
                }
              },
              child: const Text("verify Otp")
          )
        ],
      ),
    );
  }
 }
