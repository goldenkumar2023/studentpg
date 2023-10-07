import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studentpg/Studentpg/profile_page.dart';

import 'home_page.dart';
import 'notification_page.dart';

class ButtonNavigtionPage extends StatefulWidget {
  const ButtonNavigtionPage({Key? key}) : super(key: key);

  @override
  State<ButtonNavigtionPage> createState() => _ButtonNavigtionPageState();
}

class _ButtonNavigtionPageState extends State<ButtonNavigtionPage> {

  int _selectedIndex = 0;
  final pages = [
    HomePage(),
    notification(),
    profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // appBar: AppBar(
        //   title: Text(
        //     'Home Page',
        //     style: TextStyle(
        //         color: Colors.redAccent,
        //         fontWeight: FontWeight.w900,
        //         fontSize: 36),
        //   ),
        // ),
        body:pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'home',
                backgroundColor: Colors.green),
            BottomNavigationBarItem(
                icon: Icon(Icons.notification_add),
                label: 'notification',
                backgroundColor: Colors.green),
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'person',
                backgroundColor: Colors.green),
          ],
          onTap: (index){
            setState(() {
              _selectedIndex=index;
            });
          },
        ),
      ),
    );
  }
}
