
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:studentpg/Studentpg/Model/PgModels.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _homeState();
}

class _homeState extends State<HomePage> {
  PgModels? hosteldata;
  String?name;
  String?address;
  String?price;
  String?image;

  @override
  void initState() {
   retriveData().then((value){
     setState(() {
       hosteldata = value;
       name = hosteldata?.name;
       address= hosteldata?.address;
       price = hosteldata?.price;
      // image = hosteldata?.images;
     });
   });
  }

  // File? imageFile;
  // final picker = ImagePicker();
  // Future<void> pickImage(ImageSource source) async {
  //   final pickedFile = await picker.pickImage(source: source);
  //   if (pickedFile != null) {
  //     setState(() {
  //       imageFile = File(pickedFile.path);
  //       uploadImageToFirebase();
  //     });
  //   }
  // }
  //
  // Future uploadImageToFirebase() async{
  //   final auth = FirebaseAuth.instance.currentUser?.uid;
  //   if(imageFile != null){
  //     File file = File(imageFile!.path);
  //     var ref = FirebaseStorage.instance.ref().child("usersImage").child("$auth.jpg");
  //     UploadTask uploadTask = ref.putFile(file);
  //     TaskSnapshot snapshot = await uploadTask;
  //     imageUrl = await snapshot.ref.getDownloadURL();
  //   }
  // }

  // List<String> urls = [
  //
  //       " https://unsplash.com/photos/T1Yvmf4oleQ",
  //       "https://images.unsplash.com/photo-1551133990-70307d02dc94?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1887&q=80",
  //      " https://unsplash.com/photos/T1Yvmf4oleQ",
  //      "https://images.unsplash.com/photo-1551133990-70307d02dc94?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1887&q=80",
  //      " https://unsplash.com/photos/T1Yvmf4oleQ",
  //      "https://images.unsplash.com/photo-1551133990-70307d02dc94?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1887&q=80",
  //
  //      " https://unsplash.com/photos/T1Yvmf4oleQ",
  //      "https://images.unsplash.com/photo-1551133990-70307d02dc94?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1887&q=80",
  //
  //      " https://unsplash.com/photos/T1Yvmf4oleQ",
  //   " https://images.unsplash.com/photo-1620332372374-f108c53d2e03?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fGhvc3RlbHxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=500&q=60    "
  //   "https://images.unsplash.com/photo-1620332372374-f108c53d2e03?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fGhvc3RlbHxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=500&q=60"
  //
  // ];

// sometime we can face some http request erreur if the owner of the picture delted it or the url is not available.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xFFFFFFFF),
        title: Row(children: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.menu,
              color: Colors.black26,
            ),
          )
        ]),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome Student pg",
              style: TextStyle(
                color: Colors.black,
                fontSize: 26.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "Pick your destination",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Material(
              elevation: 10.0,
              borderRadius: BorderRadius.circular(30.0),
              shadowColor: Color(0x55434343),
              child: TextField(
                textAlign: TextAlign.start,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                    hintText: "Search for Hostel, Pg...",
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.black54,
                    ),
                    border: InputBorder.none),
              ),
            ),
            SizedBox(height: 30.0),
            DefaultTabController(
              length: 3,
              child: Expanded(
                child: Column(
                  children: [
                    TabBar(
                      indicatorColor: Color(0xFFFE8c68),
                      unselectedLabelColor: Color(0xFF555555),
                      labelColor: Color(0xFFFE8c68),
                      labelPadding: EdgeInsets.symmetric(horizontal: 8.0),
                      tabs: [
                        Tab(
                          text: "Trending",
                        ),
                        Tab(
                          text: "Promotions",
                        ),
                        Tab(
                          text: "Favorites",
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      height: 300.0,
                      child: TabBarView(
                        children: [
                          Container(
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [],
                            ),
                          ),
                          Container(
                            height: 280, // Adjust the height as needed
                            child: Padding(
                              padding: const EdgeInsets.only(top:10,),
                              child: PageView.builder(
                                itemCount: hosteldata?.images.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image.network(
                                        hosteldata?.images[index]??"",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }

  Future<PgModels?>retriveData() async{
    var auth = FirebaseAuth.instance.currentUser?.uid;
    var user = await FirebaseFirestore.instance.collection("hostel_booking").doc("zucbVd1tkXVI0OgLn4aj").get();
    var userModel = PgModels.fromJson(user.data()!);
    return userModel;
  }
}
