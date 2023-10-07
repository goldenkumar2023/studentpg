import 'dart:core';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'buttonnavigation.dart';

class RegisterUserSection extends StatefulWidget {
  const RegisterUserSection({Key? key}) : super(key: key);

  @override
  State<RegisterUserSection> createState() => _RegisterUserSectionState();
}

class _RegisterUserSectionState extends State<RegisterUserSection> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController gender = TextEditingController();

  String?number;

  @override
  void initState() {
    getdata();
  }

  Future getdata() async {
    var Shareprfe = await SharedPreferences.getInstance();
    setState(() {
      number = Shareprfe.getString('number')! ;
      print("number");
      print(number);
    }
    );
  }

  // The group value
  var _result;

  // get handleGenderChange => null;

  //get selectedGender => null;

  // validate() {
  //   if (name.text.length <= 3) {
  //     Fluttertoast.showToast(msg: "Invalid name");
  //   } else if (!email.text.contains("@gmail.com")) {
  //     Fluttertoast.showToast(msg: "Invalid email");
  //   } else if (phone.text.length < 10) {
  //     Fluttertoast.showToast(msg: "Invalid number");
  //   } else if (address.text.length <= 5) {
  //     Fluttertoast.showToast(msg: "Enter min 5 characters");
  //   } else if (password.text.length <= 4) {
  //     Fluttertoast.showToast(msg: "Enter min 4 characters");
  //   } else {
  //     emailAuth();
  //   }
  // }

  userdata() {

    // this code will be used to store user  data in firestore database(coloudfirestore)
    var auth = FirebaseAuth.instance.currentUser?.uid;
    FirebaseFirestore.instance.collection("users").doc(auth).set({


      "name": name.text,
      "email": email.text,
      "address": address.text,
      "age": age.text,
      "gender": gender.text,
      "number":number,
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Register Page',
        home: Scaffold(
            appBar: AppBar(
              title: const Text(
                'Registered',
                style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1),
              ),
            ),


            body: ListView(children: [

              Center(
                child: SizedBox(
                  width: 200,
                  height: 200,

                  child: const CircleAvatar(
                    backgroundImage:NetworkImage('https://www.pngkey.com/png/full/787-7877336_rand-romas-circular-headshot-gentleman.png' ) ,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 30),
                child: Center(
                  child: Text(
                    'Users Ditellas',
                    style: TextStyle(color: Colors.blue, fontSize: 20,),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 100, right: 100),
                child: TextField(
                  controller: name,
                  decoration: InputDecoration(
                      labelText: ('Enter name'),
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.only(),
                      )),
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 100, right: 100),
                child: TextField(
                  controller: email,
                  decoration: InputDecoration(
                      labelText: ('Enter email'),
                      border: UnderlineInputBorder(
                          borderRadius: BorderRadius.only())),
                ),
              ),
              const SizedBox(height: 30),

              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 100, right: 100),
                child: TextField(
                  controller: address,
                  decoration: InputDecoration(
                      labelText: ('Enter Address'),
                      border: UnderlineInputBorder(
                          borderRadius: BorderRadius.only())),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 100, right: 100, top: 30),
                child: TextField(
                  controller: age,
                  decoration: InputDecoration(
                      labelText: ('Enter age'),
                      border: UnderlineInputBorder(
                          borderRadius: BorderRadius.only())),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 100, right: 100, top: 30),
                child: TextField(
                  controller: gender,
                  decoration: InputDecoration(
                      labelText: ('gender'),
                      border: UnderlineInputBorder(
                          borderRadius: BorderRadius.only())),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Select the curect opction'),
                    RadioListTile(
                        title: const Text('Mail'),
                        value: 4,
                        groupValue: _result,
                        onChanged: (value) {
                          setState(() {
                            _result = value;
                          });
                        }),
                    RadioListTile(
                        title: const Text('Fimel'),
                        value: 5.4,
                        groupValue: _result,
                        onChanged: (value) {
                          setState(() {
                            _result = value;
                          });
                        }),
                    RadioListTile(
                        title: const Text('Other'),
                        value: 6,
                        groupValue: _result,
                        onChanged: (value) {
                          setState(() {
                            _result = value;
                          });
                        }),


                    SizedBox(height: 40),
                    Padding(
                        padding: const EdgeInsets.only(left: 100, right: 100),
                        child: SizedBox(
                          width: 300,
                          height: 37,
                          child: ElevatedButton(
                            onPressed: () {
                              userdata();
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ButtonNavigtionPage(),
                                  ));

                            },
                            child: const Text("Submit"),
                          ),
                        ))
                  ],
                ),
              ),
            ])));}}
