import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'Widgety.dart';
import '2ndscreen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:string_validator/string_validator.dart';
import 'package:connectivity/connectivity.dart';

class MyHomePage extends StatefulWidget {
  final String a;
  final List<String> s;
  MyHomePage({this.a, this.s});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  String d;
  bool iswaiting = false;

  Future<List<Jerry>> getDatah() async {
    iswaiting = true;
    var firestore = FirebaseFirestore.instance;
    if (widget.a != null) {
      QuerySnapshot qn = await firestore
          .collection("firstone")
          .where('s', isEqualTo: widget.a)
          .get();

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
    } else if (widget.s != null) {
      QuerySnapshot qn = await firestore
          .collection("firstone")
          .where('d', arrayContainsAny: widget.s)
          .get();

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
    } else {
      QuerySnapshot qn = await firestore.collection("docu").get();

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
  }

  String s = 'ConnectivityResult.wifi';
  final Connectivity _connectivity = Connectivity();
  Future<ConnectivityResult> j() async {
    ConnectivityResult result;
    result = await _connectivity.checkConnectivity();
    print('hvhjv :$result');
    String a = result.toString();
    setState(() {
      s = a;
    });
  }

  @override
  void initState() {
    super.initState();

    getDatah();
    j();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff212121),
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 30.0),
            child: IconButton(
                icon: Icon(
                  Icons.search,
                  size: 30.0,
                ),
                onPressed: () {
                  showSearch(
                      context: context, delegate: searchit(a: getDatah()));
                }),
          )
        ],
        elevation: 30.0,
        backgroundColor: Color(0xff1b212a),
        title: Text('Songs'),
      ),
      body: FutureBuilder<List<Jerry>>(
        future: getDatah(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Container(
              child: Center(
                child: SpinKitDoubleBounce(
                  size: 100.0,
                  color: Colors.white,
                ),
              ),
            );
          } else {
            return s != 'ConnectivityResult.none'
                ? ListView.builder(
                    physics: ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(1.0, 1.0, 0.0, 2.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return SecondScreen(
                                id: snapshot.data[index].id,
                                dop: snapshot.data[index].j,
                              );
                            }));
                          },
                          child: Card(
                            elevation: 30.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7.0),
                              side:
                                  BorderSide(color: Colors.white60, width: 0.8),
                            ),
                            color: Colors.black12,
                            child: Container(
                              height: 90.0,
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5.0),
                                      child: CircleAvatar(
                                        radius: 32,
                                        backgroundColor: Colors.white38,
                                        child: CircleAvatar(
                                          backgroundColor: Colors.black54,
                                          radius: 30,
                                          backgroundImage: NetworkImage(
                                              snapshot.data[index].i),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 4.0, left: 20.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10.0,
                                                bottom: 2.0,
                                                right: 0.0),
                                            child: Container(
                                              height: 50.0,
                                              width: 160.0,
                                              child: Text(
                                                snapshot.data[index].tit,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 160.0,
                                            height: 20.0,
                                            child: SingleChildScrollView(
                                              child: Text(
                                                snapshot.data[index].nameE,
                                                style: TextStyle(
                                                    color: Colors.white
                                                        .withOpacity(0.7),
                                                    fontSize: 14.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    snapshot.data[index].j != 'not available'
                                        ? InkWell(
                                            onTap: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (_) {
                                                return SecondScreen(
                                                  id: 'not available',
                                                  dop: snapshot.data[index].j,
                                                );
                                              }));
                                            },
                                            child: Card(
                                              clipBehavior: Clip.antiAlias,
                                              child: Container(
                                                height: 50.0,
                                                width: 35.0,
                                                color: Colors.teal,
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
                                            width: 20.0,
                                          ),
                                    snapshot.data[index].id != 'not available'
                                        ? Padding(
                                            padding: const EdgeInsets.all(0.0),
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (_) {
                                                  return SecondScreen(
                                                    id: snapshot.data[index].id,
                                                    dop: null,
                                                  );
                                                }));
                                              },
                                              child: Card(
                                                clipBehavior: Clip.antiAlias,
                                                child: Container(
                                                  height: 50.0,
                                                  width: 35.0,
                                                  color: Colors.blue,
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
                        ),
                      );
                    })
                : AlertDialog(
                    title: Row(
                      children: [
                        Icon(Icons.error),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          'No Internet Connection',
                          style:
                              TextStyle(color: Colors.black87.withOpacity(0.8)),
                        ),
                      ],
                    ),
                    content: Text(
                      'You are offline please check your internet connection',
                      style: TextStyle(
                          color: Colors.teal, fontWeight: FontWeight.bold),
                    ),
                    actions: [
                      FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Ok'))
                    ],
                  );
          }
        },
      ),
    );
  }
}

class searchit extends SearchDelegate<String> {
  final Future<List<Jerry>> a;

  searchit({this.a});

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
                      padding: const EdgeInsets.fromLTRB(1.0, 9.0, 0.0, 2.0),
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
                          height: 70.0,
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
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          width: 220.0,
                                          child: SingleChildScrollView(
                                            child: Text(
                                              e.nameE,
                                              style: TextStyle(
                                                  color: Colors.white
                                                      .withOpacity(0.8),
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold),
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
                                                MaterialPageRoute(builder: (_) {
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
                .toList(),
          );
        }
      },
    );
  }
}
