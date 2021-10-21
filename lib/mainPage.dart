import 'dart:async';
import 'package:flutter_jerryg/homaPage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'Widgety.dart';
import 'selectionDraw.dart';
import 'package:flutter/material.dart';
import 'saitsPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:string_validator/string_validator.dart';
import '2ndscreen.dart';

const String testdevice = 'YOUR_DEVICE_ID';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  String d;
  bool iswaiting = false;
  String s;
  String y = '';

  Future<List<Jerry>> getData() async {
    iswaiting = true;
    var firestore = FirebaseFirestore.instance;

    QuerySnapshot qn = await firestore.collection("firstone").get();

    List<Jerry> jerrys = [];
    List<String> z = [];
    for (var y in qn.docs) {
      var t = y.data()['url'] == null ? 'not available' : y.data()['url'];
      String titi = y.data()['name'];
      String pada =
          y.data()['lyrics'] == null ? 'not available' : y.data()['lyrics'];
      String ima = y.data()['thumb'];
      String nameE = y.data()['nameE'];
      Jerry jerry = Jerry(ima, pada, t, titi, nameE);
      jerrys.add(jerry);
    }

    iswaiting = false;
    print(jerrys.length);
    return jerrys;
  }

  void getper() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var name = preferences.getString('name');
    setState(() {
      s = name;
    });
    var image = preferences.getString('imageurl');
    setState(() {
      y = image;
    });
  }

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
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    return Future.value(true);
  }

  bool showspinner = false;
  @override
  void initState() {
    super.initState();
    getper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff212121),
        appBar: AppBar(
          elevation: 10.0,
          actions: [
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  showSearch(context: context, delegate: searcht(a: getData()));
                })
          ],
          backgroundColor: Color(0xff121212),
          title: Text('Home'),
        ),
        drawer: s == null
            ? B(() async {
                try {
                  final newuser = await googlesignin();
                  if (newuser != null) {
                    SharedPreferences preferences =
                        await SharedPreferences.getInstance();
                    preferences.setString('name', newuser.displayName);
                    preferences.setString('imageurl', newuser.photoURL);
                    preferences.setString('email', newuser.email);
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return Home();
                    }));
                  }
                } catch (e) {
                  print(e);
                }
              }, () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return Settingg();
                }));
              }, () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return Aboutus();
                }));
              })
            : A(s, y, () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return profile();
                }));
              }, () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return Settingg();
                }));
              }, () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return Aboutus();
                }));
              }, () async {
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
              }),
        body: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 6.0),
                child: Container(
                  child: tamandeng(
                    tamil: 'திருப்பலி பாடல்கள் ',
                    english: 'Church mass songs',
                  ),
                ),
              ),
              Container(
                height: 130.0,
                width: double.infinity,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 2.0, right: 5.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            topcon(
                              a: [Color(0xff223852), Color(0xff152033)],
                              text: 'தியானப் பாடல்கள்',
                              g: MyHomePage(
                                s: ['t'],
                              ),
                              d: 10.9,
                            ),
                            SizedBox(
                              width: 9.4,
                            ),
                            topcon(
                              a: [Color(0xff28011f), Color(0xff6b0103)],
                              text: 'வருகைப் பாடல்கள்',
                              g: MyHomePage(
                                s: ['v'],
                              ),
                              d: 10.9,
                            ),
                          ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            topcon(
                                a: [Color(0xff402758), Color(0xff300944)],
                                text: 'காணிக்கைப் பாடல்கள்',
                                d: 10.6,
                                g: MyHomePage(
                                  s: ['k'],
                                )),
                            SizedBox(
                              width: 10.0,
                            ),
                            topcon(
                              a: [Color(0xff244b62), Color(0xff152133)],
                              text: ' திருவிருந்து & நன்றிப் பாடல்கள்',
                              g: MyHomePage(
                                s: ['n'],
                              ),
                              d: 9.9,
                            ),
                          ]),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 8.0, right: 8.0, bottom: 8.0, top: 10.0),
                child: Container(
                  height: 40.0,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      tamandeng(
                        tamil: 'அருட்தொண்டர்கள்',
                        english: 'Saints',
                      ),
                      Arrow(
                        s: SaintsList(),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 0.4, color: Colors.white),
                  ),
                ),
                height: 210.0,
                width: double.infinity,
                child: ListView(
                  // This next line does the trick.
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    cardW(
                      j: 'images/virjpg-min.jpg',
                      h: 'புனித மரியை',
                      ine: 'st.Mary',
                      u: MyHomePage(a: 'st.Mary'),
                    ),
                    cardW(
                      j: 'images/Sa.jpg',
                      h: 'புனித சூசையப்பர்',
                      ine: 'st.Joseph',
                      u: MyHomePage(a: 'st.Joseph'),
                    ),
                    cardW(
                      j: 'images/un-min.jpg',
                      h: 'புனித அந்தோணியார் ',
                      ine: 'st.Anthony of Padua',
                      u: MyHomePage(a: 'st.Anthony of Padua'),
                    ),
                    cardW(
                      j: 'images/thoms-min.jpg',
                      h: 'புனித தோமையார்',
                      ine: 'st.Thomas the Apostle',
                      u: MyHomePage(a: 'st.Thomas the Apostle'),
                    ),
                    Container(
                      width: 90.0,
                      child: Container(
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 90.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return SaintsList();
                              }));
                            },
                            child: Card(
                              elevation: 30.0,
                              shadowColor: Colors.black,
                              color: Color(0xff1b212a),
                              clipBehavior: Clip.antiAlias,
                              shape: RoundedRectangleBorder(
                                side:
                                    BorderSide(color: Colors.white, width: 0.9),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              child: Container(
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 25.0,
                                  color: Colors.white.withOpacity(0.6),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                child: Container(
                  width: double.infinity,
                  height: 190.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: cardW(
                            j: 'images/bibble.jpg',
                            h: 'இயேசு கிறிஸ்து',
                            ine: 'Jesus Christ',
                            u: MyHomePage(s: ['j']),
                            p: 2),
                      ),
                      Expanded(
                        child: cardW(
                          j: 'images/heavenly-court-min.jpg',
                          h: 'புனிதர்களின்\nவரலாறு',
                          ine: 'History of saints',
                          u: MyHomePage(),
                          p: 2,
                          y: BoxFit.cover,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 6.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 15.0),
                      child: tamandeng(
                        tamil: 'தவக்காலம்',
                        english: 'Lent season',
                      ),
                    ),
                    Arrow(
                      s: MyHomePage(
                        a: 't',
                      ),
                    ),
                  ],
                ),
              ),
              siluvai(
                tamil: 'சிலுவைப்பாதை',
                english: 'Way of Cross',
                url: 'images/cross.jpg',
                f: MyHomePage(a: 'si'),
              ),
              siluvai(
                tamil: 'குருத்து ஞாயிறு',
                english: 'Palm Sunday ',
                url: 'images/palm.png',
                f: MyHomePage(a: 'k'),
              ),
              siluvai(
                tamil: 'புனித வியாழன்',
                english: 'Maundy Thursday ',
                url: 'images/wed.jpg',
                f: MyHomePage(a: 'vi'),
              ),
              siluvai(
                  tamil: 'புனித வெள்ளி',
                  english: 'Good friday ',
                  url: 'images/gdd.jpg',
                  f: MyHomePage(a: 've'))
            ],
          ),
        ));
  }
}

class Arrow extends StatelessWidget {
  final Widget s;
  Arrow({this.s});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return s;
        }));
      },
      child: Card(
        elevation: 5.0,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.teal, width: 0.8),
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Container(
          height: 40.0,
          width: 40.0,
          color: Color(0xff1b212a),
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Row(
              children: [
                Icon(
                  Icons.arrow_forward_ios,
                  size: 20.0,
                  color: Colors.teal.withOpacity(0.6),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class topcon extends StatelessWidget {
  final List<Color> a;
  final Widget g;
  final String text;
  final double d;
  topcon({this.a, this.text, this.g, this.d});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 0.0),
        child: GestureDetector(
          child: Card(
            elevation: 20.0 ,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.white, width: 1.5),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Container(
              height: 50.0,
              width: 160.0,
              child: Material(
                child: Ink(
                  decoration:
                      BoxDecoration(gradient: LinearGradient(colors: a)),
                  child: InkWell(
                    onTap: g == null
                        ? () {}
                        : () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return g;
                            }));
                          },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          text,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: d),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class tamandeng extends StatelessWidget {
  final String tamil;
  final String english;
  final Function onPress;

  tamandeng({this.english, this.tamil, this.onPress});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tamil,
          style: TextStyle(
              fontSize: 14.0,
              color: Color(0xffffffff),
              fontWeight: FontWeight.bold),
        ),
        Text(
          english,
          style: TextStyle(
              fontSize: 14.0,
              color: Color(0xffffffff).withOpacity(0.7),
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class searcht extends SearchDelegate<String> {
  final Future<List<Jerry>> a;

  searcht({this.a});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    assert(theme != null);
    return theme.copyWith(
      primaryColor: Color(0xff1b212a),
      primaryIconTheme: theme.primaryIconTheme.copyWith(color: Colors.white),
      primaryColorBrightness: Brightness.light,
      primaryTextTheme: theme.textTheme,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<Jerry>>(
      future: a,
      builder: (BuildContext context, AsyncSnapshot<List<Jerry>> snapshot) {
        if (snapshot.data == null) {
          return Container(
            child: Center(
              child: Text('loading'),
            ),
          );
        } else {
          final result = isAlpha(query)
              ? snapshot.data
                  .where((e) => e.nameE.toLowerCase().contains(query))
              : snapshot.data.where((e) => e.tit.contains(query));

          return ListView(
              children: result
                  .map<Widget>((e) => Padding(
                        padding: const EdgeInsets.fromLTRB(1.0, 8.0, 0.0, 2.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return SecondScreen(
                                id: e.id,
                                dop: e.j,
                              );
                            }));
                          },
                          child: Container(
                            color: Color(0xff424242),
                            height: 60.0,
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 4.0, left: 20.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5.0,
                                                bottom: 0.0,
                                                right: 0.0),
                                            child: Container(
                                              width: 220.0,
                                              child: Text(
                                                e.tit,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            width: 220.0,
                                            child: SingleChildScrollView(
                                              child: Text(
                                                e.nameE,
                                                style: TextStyle(
                                                    color: Colors.white
                                                        .withOpacity(0.8),
                                                    fontSize: 16.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  e.j != 'not available'
                                      ? InkWell(
                                          onTap: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(builder: (_) {
                                              return SecondScreen(
                                                id: 'not available',
                                                dop: e.j,
                                              );
                                            }));
                                          },
                                          child: Card(
                                            clipBehavior: Clip.antiAlias,
                                            child: Container(
                                              height: 35.0,
                                              width: 40.0,
                                              color: Colors.grey,
                                              child: Center(
                                                child: Icon(
                                                  Icons.chat,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : SizedBox(
                                          width: 30.0,
                                        ),
                                  e.id != 'not available'
                                      ? Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (_) {
                                                return SecondScreen(
                                                  id: e.id,
                                                  dop: null,
                                                );
                                              }));
                                            },
                                            child: Card(
                                              clipBehavior: Clip.antiAlias,
                                              child: Container(
                                                height: 35.0,
                                                width: 40.0,
                                                color: Colors.grey,
                                                child: Center(
                                                  child: Icon(
                                                    Icons.ondemand_video,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : SizedBox(
                                          width: 20.0,
                                        ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ))
                  .toList());
        }
      },
    );
  }
}
