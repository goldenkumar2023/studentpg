import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class notification extends StatefulWidget {
  const notification({Key? key}) : super(key: key);

  @override
  State<notification> createState() => _notificationState();
}

class _notificationState extends State<notification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: 50),
              child: Text(
                'notification',
                style: TextStyle(
                    color: Colors.lime,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
            ),
          )
        ],
      ),
    );
  }
}
