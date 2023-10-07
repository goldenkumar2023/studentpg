
import 'package:flutter/material.dart';
import 'package:studentpg/Studentpg/home_page.dart';
import 'package:studentpg/Studentpg/user_details.dart';
import 'Model/Emailauth/login_withemail.dart';
import 'enter_number.dart';


class loginpage extends StatefulWidget {
  const loginpage({Key? key}) : super(key: key);

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "LOGIN",
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Simple login page',
            style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1),
          ),
        ),
        body: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 70),
              child: Center(
                child: Text(
                  'LOGIN|signup',
                  style: TextStyle(color: Colors.blue, fontSize: 35),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 30),
              child: Center(
                child: Text(
                  '',
                  style: TextStyle(color: Colors.blue, fontSize: 36),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.only(right: 100, left: 100),
              child: SizedBox(
                width: 300,
                height: 37,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PhoneNumber(),
                        ));
                  },
                  icon: SizedBox(child: const Icon(Icons.phone)),
                  //icon data for elevated button
                  label: Text('User login OtP'),
                  style: ElevatedButton.styleFrom(
                      primary:
                      Colors.blueAccent //elevated btton background color
                  ),
                ),

              ),
            ),

            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.only(right: 100, left: 100),
              child: SizedBox(
                width: 300,
                height: 37,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>login_withemail(),
                        ));
                  },
                  icon: SizedBox(child: const Icon(Icons.email)),
                  //icon data for elevated button
                  label: Text('User login with email'),
                  style: ElevatedButton.styleFrom(
                      primary:
                      Colors.blueAccent //elevated btton background color
                  ),
                ),

              ),
            ),

            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.only(right: 100, left: 100),
              child: SizedBox(
                width: 300,
                height: 37,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    );
                  },
                  icon: SizedBox(
                    width: 24,
                    height: 24,
                    child: Image.asset('img_1.png'), // Update with your image path
                  ),
                  label: Text('User login with Google'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blueAccent,
                  ),
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () =>
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>RegisterUserSection (),
                          )),
                  child: Padding(
                    padding: EdgeInsets.only(top: 90),
                    child: Text(
                      "Don't Have an Account?Sing up",
                      style: TextStyle(color: Colors.blue, fontSize: 15),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

