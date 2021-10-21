import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'mainPage.dart';
import 'dart:async';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SigninPage extends StatefulWidget {
  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  Future<User> googlesignin() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final GoogleAuthCredential googleCredential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential googleUserCredential =
        await FirebaseAuth.instance.signInWithCredential(googleCredential);
    User user = FirebaseAuth.instance.currentUser;
    print(user.uid);
    return user;
  }

  Future<bool> gsignout() async {
    await GoogleSignIn().signIn();
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff1b212a),
        title: Text('demo'),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () async {
              try {
                final newuser = await googlesignin();
                if (newuser != null) {
                  SharedPreferences preferences =
                      await SharedPreferences.getInstance();
                  preferences.setString('name', newuser.displayName);
                  preferences.setString('imageurl', newuser.photoURL);
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return Home();
                  }));
                }
              } catch (e) {
                print(e);
              }
            },
            child: Center(
              child: Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.white60, width: 0.2),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Container(
                  width: 200.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/gs.png'), fit: BoxFit.fill),
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              try {
                bool a = await gsignout();
                if (a == true) {
                  SharedPreferences preferences =
                      await SharedPreferences.getInstance();
                  preferences.setString('name', null);
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return Home();
                  }));
                }
              } catch (e) {
                print(e);
              }
            },
            child: Center(
              child: Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.white60, width: 0.2),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Container(
                  width: 200.0,
                  height: 40.0,
                  child: Center(child: Text('Log out')),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
