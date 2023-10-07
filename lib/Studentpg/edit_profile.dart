import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'Model/User_datamodel.dart';


class editprofile extends StatefulWidget {
  const editprofile({Key? key}) : super(key: key);

  @override
  State<editprofile> createState() => _editprofileState();
}

class _editprofileState extends State<editprofile> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController age = TextEditingController();

  UserModel? userDataModel;

  PickedFile? imageFile;
  final picker = ImagePicker();

  String? imageUrl;


  @override

  void initState() {
    super.initState();
    retriveData().then((value) {
      setState(() {
        userDataModel = value;
        name.text = userDataModel ?.name?? "";
        email.text =  userDataModel?.email ?? "";

        address.text =  userDataModel?.address ?? "";


      });
    });
  }

  Future<UserModel?> retriveData() async {
    var auth = FirebaseAuth.instance.currentUser?.uid;
    var user = await FirebaseFirestore.instance.collection("users").doc(auth).get();
    var userModel =  UserModel.fromJson(user.data()!);
    return userModel;
  }

  @override
  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);
    setState(() {
      imageFile = pickedFile;
    });
  }

  Future<void> uploadImageToFirebase() async {
    final auth = FirebaseAuth.instance.currentUser?.uid;
    if (imageFile != null) {
      File file = File(imageFile!.path);
      var ref =
      FirebaseStorage.instance.ref().child('usersImage').child('$auth.jpg');
      UploadTask uploadTask = ref.putFile(file as File);
      TaskSnapshot snapshot = await uploadTask;
      imageUrl = await snapshot.ref.getDownloadURL();
    }
  }

  void updateUser() async {
    var auth = FirebaseAuth.instance.currentUser?.uid;
    await  uploadImageToFirebase();
    FirebaseFirestore.instance.collection("users").doc(auth).update({
      "name": name.text.trim(),
      "email": email.text.trim(),
      "phone": phone.text.trim(),
      "address": address.text.trim(),
      "imageUrl":imageUrl
    }).then((value){
      //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(),));
    });
  }


  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: const Text('EditProfilePage'),
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  imageFile != null ?
                  CircleAvatar(
                      radius: 50,
                      backgroundImage: FileImage(File(imageFile!.path))
                  ):
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: imageUrl != "" ? NetworkImage("${imageUrl}") : const NetworkImage("https://firebasestorage.googleapis.com/v0/b/flutterbasic-a5dcc.appspot.com/o/usersImage%2Fpic.webp?alt=media&token=6141432e-12ce-4633-a270-dfcecc902371"),

                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.camera,color: Colors.blue),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Wrap(
                                children: [
                                  ListTile(
                                    leading: const Icon(
                                      Icons.camera_alt,
                                      color: Colors.blue,
                                    ),
                                    title: const Text('Camera'),
                                    onTap: () {
                                      pickImage(ImageSource.camera);
                                      Navigator.pop(context);
                                    },
                                  ),
                                  ListTile(
                                    leading: const Icon(
                                      Icons.image,
                                      color: Colors.blue,
                                    ),
                                    title: const Text('Gallery'),
                                    onTap: () {
                                      pickImage(ImageSource.gallery);
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20, left: 45),
            child: Text(
              'Name',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
          const SizedBox(
            height: 2,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35, right: 35),
            child: SizedBox(
              height: 65,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Colors.white,
                elevation: 15,
                child: TextField(
                  controller: name,
                  cursorColor: Colors.blue,
                  style: const TextStyle(color: Colors.blue),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.person,
                      color: CupertinoColors.systemBlue,
                    ),
                    hintText: "${userDataModel?.name}",
                    hintStyle: const TextStyle(color: Colors.blue),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 18),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 1, //<-- SEE HERE
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10, left: 45),
            child: Text(
              'email ',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
          const SizedBox(
            height: 2,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35, right: 35),
            child: SizedBox(
              height: 65,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Colors.white,
                elevation: 15,
                child: TextField(
                  textAlignVertical: TextAlignVertical.center,
                  controller: email,
                  cursorColor: Colors.white,
                  style: const TextStyle(color: Colors.blue),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.phone_android_outlined,
                      color: CupertinoColors.systemBlue,
                    ),
                    hintText: "${ userDataModel?.email}",
                    hintStyle: const TextStyle(color: Colors.blue),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 1, //<-- SEE HERE
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10, left: 45),
            child: Text(
              'Address',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
          const SizedBox(
            height: 2,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35, right: 35),
            child: SizedBox(
              height: 65,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Colors.white,
                shadowColor: Colors.white,
                elevation: 15,
                child: TextField(
                  controller: phone,
                  cursorColor: Colors.blue,
                  style: const TextStyle(color: Colors.blue),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.phone,
                      color: CupertinoColors.systemBlue,
                    ),
                    hintText: "${ userDataModel?.phone}",
                    hintStyle: const TextStyle(color: Colors.blue),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 18),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 1, //<-- SEE HERE
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10, left: 45),
            child: Text(
              'Age',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),



          const SizedBox(
            height: 2,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35, right: 35),
            child: SizedBox(
              height: 65,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Colors.white,
                elevation: 15,
                child: TextField(
                  controller: name,
                  cursorColor: Colors.blue,
                  style: const TextStyle(color: Colors.blue),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.person,
                      color: CupertinoColors.systemBlue,
                    ),
                    hintText: "${userDataModel?.name}",
                    hintStyle: const TextStyle(color: Colors.blue),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 18),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 1, //<-- SEE HERE
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10, left: 45),
            child: Text(
              'Gender ',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),




          Padding(

            padding: const EdgeInsets.only(left: 40, right: 40),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 10,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40.0, vertical: 20.0),
                  primary: Colors.white,
                  shape: const StadiumBorder(),
                ),
                onPressed: () {
                  updateUser();
                },
                child: const Text(
                  'Update',
                  style: TextStyle(color: Colors.blue),
                )),
          ),
        ],
      ),
    );
  }
}


