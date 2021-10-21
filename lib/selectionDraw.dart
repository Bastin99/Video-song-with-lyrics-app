import 'dart:math';
import 'package:flutter_jerryg/main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Widgety.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'mainPage.dart';
import 'p&a.dart';

Widget A(String a, String e, Function u, Function h, Function j, Function o) {
  return Container(
    width: 220.0,
    child: Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.teal, Colors.lightBlueAccent])),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Container(
                    child: Text(
                      a,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 18.0),
                    ),
                  ),
                ),
                Container(
                  height: 70.0,
                  width: 70.0,
                  child: CircleAvatar(
                    radius: 40.0,
                    backgroundImage: NetworkImage(e),
                  ),
                ),
              ],
            ),
          ),
          NewDRtilt(Icons.account_circle, 'Profile', u),
          NewDRtilt(Icons.settings, 'Settings', h),
          NewDRtilt(Icons.error, 'About us', j),
          NewDRtilt(Icons.exit_to_app, 'Log out', o)
        ],
      ),
    ),
  );
}

Widget B(Function u, Function h, Function j) {
  return Container(
    width: 220.0,
    child: Drawer(
      child: ListView(
        children: [
          Container(
            child: DrawerHeader(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                    Colors.black54,
                    Colors.white60,
                  ])),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Container(
                      child: Text(
                        'You are not logged in',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 18.0),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: u,
                    child: Container(
                      height: 35.0,
                      width: 187.0,
                      child: Image.asset('images/gs.png'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          NewDRtilt(Icons.settings, 'Settings', h),
          NewDRtilt(Icons.error, 'About us', j),
        ],
      ),
    ),
  );
}

class Aboutus extends StatefulWidget {
  @override
  _AboutusState createState() => _AboutusState();
}

class _AboutusState extends State<Aboutus> {
  @override
  Widget build(BuildContext context) {
    TextStyle d = TextStyle(color: Colors.white);
    TextStyle p = TextStyle(color: Colors.blueAccent);
    return Scaffold(
      appBar: AppBar(
        elevation: 50.0,
        backgroundColor: Color(0xff121212),
        title: Text('About us'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Card(
                color: Colors.black38,
                child: ExpansionTile(
                  title: Text(
                    'Terms and Conditions',
                    style: p,
                  ),
                  children: [
                    Text(
                      h(),
                      style: d,
                    )
                  ],
                ),
              ),
              Card(
                color: Colors.black38,
                child: ExpansionTile(
                  title: Text(
                    'Privacy and Policies',
                    style: p,
                  ),
                  children: [
                    Text(
                      g(),
                      style: d,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Settingg extends StatefulWidget {
  @override
  _SettinggState createState() => _SettinggState();
}

class _SettinggState extends State<Settingg> {
  int d;
  int f;
  int y;
  void getper() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var name = preferences.getInt('initial');
    setState(() {
      d = name;
    });
    var k = preferences.getInt('initial1');
    setState(() {
      f = k;
    });
    var p = preferences.getInt('initial2');
    setState(() {
      y = p;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 50.0,
        backgroundColor: Color(0xff121212),
        title: Text('Settings'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'தானியக்கம் ',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                'Autoplay',
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.white.withOpacity(0.8),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              ToggleSwitch(
                initialLabelIndex: f == null ? 1 : f,
                minWidth: 90.0,
                cornerRadius: 20.0,
                activeFgColor: Colors.white,
                inactiveBgColor: Colors.grey,
                inactiveFgColor: Colors.white,
                labels: ['Off', 'ON'],
                activeBgColors: [
                  Colors.redAccent,
                  Colors.blue,
                ],
                onToggle: (index) async {
                  if (index == 0) {
                    SharedPreferences sharedPreferences =
                        await SharedPreferences.getInstance();
                    sharedPreferences.setBool('l', false);
                    sharedPreferences.setInt('initial1', index);
                  } else if (index == 1) {
                    SharedPreferences sharedPreferences =
                        await SharedPreferences.getInstance();
                    sharedPreferences.setBool('l', true);
                    sharedPreferences.setInt('initial1', index);
                  }
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'வீடியோ தரம்',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                'Video quality',
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.white.withOpacity(0.8),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              ToggleSwitch(
                initialLabelIndex: y == null ? 0 : y,
                minWidth: 106.0,
                cornerRadius: 20.0,
                activeFgColor: Colors.white,
                inactiveBgColor: Colors.grey,
                inactiveFgColor: Colors.white,
                labels: ['Based on \n connectivity  ', 'Force \nHD'],
                activeBgColors: [
                  Colors.redAccent,
                  Colors.blue,
                ],
                onToggle: (index) async {
                  if (index == 0) {
                    SharedPreferences sharedPreferences =
                        await SharedPreferences.getInstance();
                    sharedPreferences.setBool('p', false);
                    sharedPreferences.setInt('initial2', index);
                  } else if (index == 1) {
                    SharedPreferences sharedPreferences =
                        await SharedPreferences.getInstance();
                    sharedPreferences.setBool('p', true);
                    sharedPreferences.setInt('initial2', index);
                  }
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'பாடல்வரி எழுத்தின் அளவு',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                'Font size for lyrics',
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.white.withOpacity(0.8),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              ToggleSwitch(
                initialLabelIndex: d == null ? 0 : d,
                minWidth: 90.0,
                cornerRadius: 20.0,
                activeFgColor: Colors.white,
                inactiveBgColor: Colors.grey,
                inactiveFgColor: Colors.white,
                labels: ['Small', 'Big', 'Bigget'],
                activeBgColors: [Colors.blue, Colors.pink, Colors.redAccent],
                onToggle: (index) async {
                  if (index == 0) {
                    SharedPreferences sharedPreferences =
                        await SharedPreferences.getInstance();
                    sharedPreferences.setDouble('size', 15);
                    sharedPreferences.setInt('initial', index);
                  } else if (index == 1) {
                    SharedPreferences sharedPreferences =
                        await SharedPreferences.getInstance();
                    sharedPreferences.setDouble('size', 18);
                    sharedPreferences.setInt('initial', index);
                  } else if (index == 2) {
                    SharedPreferences sharedPreferences =
                        await SharedPreferences.getInstance();
                    sharedPreferences.setDouble('size', 21);
                    sharedPreferences.setInt('initial', index);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class profile extends StatefulWidget {
  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {
  String s = '';
  String email = '';
  String d = '';
  void getper() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var name = preferences.getString('name');
    setState(() {
      s = name;
    });
    var image = preferences.getString('imageurl');
    setState(() {
      d = image;
    });
    var Email = preferences.getString('email');
    setState(() {
      email = Email;
    });
  }

  Future<bool> gsignout() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    return Future.value(true);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 50.0,
        backgroundColor: Color(0xff121212),
        title: Text('My profile'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 60.0,
                width: 90.0,
              ),
              Container(
                height: 100.0,
                width: 100.0,
                child: CircleAvatar(
                  backgroundImage: NetworkImage('$d'),
                ),
              ),
              SizedBox(
                height: 30.0,
                width: 90.0,
              ),
              Card(
                color: Colors.white12,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.white60, width: 1.0),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Container(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 20.0, 6.0, 20.0),
                      child: Text(
                        '$s',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 19.0),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Card(
                color: Colors.white12,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.white60, width: 1.0),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 20.0, 6.0, 20.0),
                  child: Container(
                    child: Center(
                      child: Text(
                        '$email',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17.0),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              InkWell(
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
                child: Card(
                  color: Colors.redAccent,
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white60, width: 1.0),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Container(
                    height: 50.0,
                    width: 150.0,
                    child: FlatButton(
                        onPressed: null,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Row(
                            children: [
                              Icon(Icons.exit_to_app),
                              Text(
                                '   Logout',
                                style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        )),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
