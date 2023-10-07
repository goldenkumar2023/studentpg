import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';

import '../../buttonnavigation.dart';

class login_withemail extends StatefulWidget {
  const login_withemail({Key? key}) : super(key: key);

  @override
  State<login_withemail> createState() => _enteryour_emailState();
}

class _enteryour_emailState extends State<login_withemail> {
  TextEditingController Email = TextEditingController();
  TextEditingController Password = TextEditingController();



  validate() {
    if (!Email.text.contains("@gmail.com")) {
      Fluttertoast.showToast(msg: " invalid email");
    }
   else if(!Email.text.startsWith(RegExp(r'[a-z]'))){
      Fluttertoast.showToast(msg: "Email should start with a lowercase");
    }
    
    
    else if (Password.text.length <=8) {
      Fluttertoast.showToast(msg: " invalid password");
    }
    else if(!Password.text.contains(RegExp(r'[A-Z]'))){
      Fluttertoast.showToast(msg: "Password must start with  uppercase ");
    }
    else if(!Password.text.contains(RegExp(r'[0-9]'))){
      Fluttertoast.showToast(msg: " number must be required in password");
    }
    else if(!Password.text.contains(RegExp(r'[@#$%&*.,]'))){
      Fluttertoast.showToast(msg: " special characters not flowing");
    }

    firebaseAuth();
  }

  firebaseAuth() {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: Email.text, password: Password.text)
        .then((value) {
      userDataStore();
    });
  }

  userDataStore() {
    var auth = FirebaseAuth.instance.currentUser?.uid;
    FirebaseFirestore.instance.collection("users").doc(auth).set({
      "email": Email.text.toString(),
      "password": Password.text.toString(),
    }).then((value) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ButtonNavigtionPage(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        //Lottie.network("https://iconscout.com/3d/mobile-mail-5652897"),
        const Center(
          child: Padding(
            padding: EdgeInsets.only(top: 40),
            child: Text(
              "Sign in with Email",
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 35,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),

        Padding(
          padding: EdgeInsets.only(right: 30, left: 30, top: 20),
          child: TextField(
            controller: Email,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: "Enter your Email",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ),

        Padding(
          padding: EdgeInsets.only(right: 30, left: 30, top: 20),
          child: TextField(
            controller: Password,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: "Enter Your Password",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ),

        ElevatedButton(
            onPressed: (){
         validate();
         }, child: Text("Submit"))

      ]

      ),
    );
  }
}
