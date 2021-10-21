import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_jerryg/Widgety.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'homaPage.dart';

class SaintsList extends StatefulWidget {
  @override
  _SaintsListState createState() => _SaintsListState();
}

class _SaintsListState extends State<SaintsList> {
  var firestore = FirebaseFirestore.instance;
  bool iswaiting = false;
  Future<List<KGF>> getDatah() async {
    iswaiting = true;
    var firestore = FirebaseFirestore.instance;

    QuerySnapshot qn = await firestore.collection("saints").get();
    List<KGF> kgfs = [];
    List<String> z = [];
    for (var y in qn.docs) {
      String t = y.data()['image' ];
      String titi = y.data()['nameT'];
      String pada = y.data()['nameE'];
      KGF jerry = KGF(t, titi, pada);
      kgfs.add(jerry);
    }
    iswaiting = false;
    print(kgfs.length);
    return kgfs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff212121),
      appBar: AppBar(
        backgroundColor: Color(0xff1b212a),
        title: Text('saints'),
      ),
      body: FutureBuilder<List<KGF>>(
        future: getDatah(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Container(
              child: Center(
                child: SpinKitDoubleBounce(
                  size: 110.0,
                  color: Colors.white,
                ),
              ),
            );
          } else {
            return GridView.builder(
                physics: ClampingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 1.0),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return cardN(
                    j: snapshot.data[index].imageurl,
                    h: snapshot.data[index].nameT,
                    ine: snapshot.data[index].nameE,
                    u: MyHomePage(
                      a: snapshot.data[index].nameT,
                    ),
                  );
                });
          }
        },
      ),
    );
  }
}
