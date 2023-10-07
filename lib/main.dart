import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:studentpg/Studentpg/home_page.dart';
import 'Studentpg/splash_screen.dart';
import 'firebase_options.dart';
import 'package:flutter/cupertino.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(myapp());
}
class myapp extends StatelessWidget {

const myapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Room Booking App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      //home:SplashScreen() ,
        //home: MapCurrent(),
    );
  }
}

