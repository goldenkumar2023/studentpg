import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:studentpg/Studentpg/home_page.dart';

class LoginWithGoogle extends StatefulWidget {
  const LoginWithGoogle({Key? key}) : super(key: key);

  @override
  _LoginWithGoogleState createState() => _LoginWithGoogleState();
}

class _LoginWithGoogleState extends State<LoginWithGoogle> {
  final List<String> recentEmails = ["user@example.com", "another@example.com"];
  String selectedEmail = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Email Selection"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  selectedEmail = value;
                });
              },
              decoration: InputDecoration(
                labelText: "Enter your email",
              ),
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              hint: Text("Select a recent email"),
              value: selectedEmail,
              onChanged: (newValue) {
                setState(() {
                  selectedEmail = newValue!;
                });
              },
              items: recentEmails.map((email) {
                return DropdownMenuItem<String>(
                  value: email,
                  child: Text(email),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: selectedEmail.isNotEmpty
                  ? () {
                signInWithGoogle().then((userCredential) {
                  if (userCredential != null) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    );
                  }
                });
              }
                  : null,
              child: Text("Continue"),
            ),
          ],
        ),
      ),
    );
  }

  Future<UserCredential?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      return FirebaseAuth.instance.signInWithCredential(credential);
    }
    return null;
  }
}

void main() {
  runApp(MaterialApp(
    home: LoginWithGoogle(),
  ));
}