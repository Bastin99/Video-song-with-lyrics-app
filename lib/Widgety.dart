import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class fBuilder extends StatelessWidget {
  final String a;
  fBuilder({@required this.a});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection("photos")
          .doc(a)
          .get(), //get the data,
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.data == null) {
          return Center(
            child: CircularProgressIndicator(backgroundColor: Colors.blue),
          );
        } else {
          Map<String, dynamic> data = snapshot.data.data();
          return FittedBox(
            child: Image(image: NetworkImage(data['image'])),
            fit: BoxFit.fill,
          );
        }
      },
    );
  }
}

class Jerry {
  final String i;
  final String j;
  final String id;
  final String tit;
  final String nameE;
  Jerry(this.i, this.j, this.id, this.tit, this.nameE);
} //

class NewDRtilt extends StatelessWidget {
  final String text;
  final IconData a;
  final Function d;
  NewDRtilt(this.a, this.text, this.d);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: d,
      child: Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: Container(
          color: Color(0xff03dac5).withOpacity(0.7),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 30.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(a),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(text),
                      )
                    ],
                  ),
                  Icon(Icons.arrow_right)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class cardW extends StatelessWidget {
  final String j;
  final String h;
  final int p;
  final String ine;
  final Widget u;
  final BoxFit y;
  cardW(
      {@required this.j,
      @required this.h,
      this.p,
      @required this.ine,
      this.u,
      this.y});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.white,
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return u;
        }));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: p == null ? 2 : p,
            child: Card(
              color: Color(0xff1e1e1e),
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.white, width: 1.5),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(
                width: 160.0,
                color: Color(0xff1e1e1e),
                child: FittedBox(
                  child: Image(
                      image: AssetImage('$j') == null
                          ? NetworkImage('$j')
                          : AssetImage('$j')),
                  fit: y == null ? BoxFit.fitWidth : y,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 13.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      h,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13.0),
                    ),
                    SingleChildScrollView(
                      child: Text(
                        ine,
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class cardN extends StatelessWidget {
  final String j;
  final String h;
  final int p;
  final String ine;
  final Widget u;
  cardN(
      {@required this.j, @required this.h, this.p, @required this.ine, this.u});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return u;
        }));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Card(
              color: Color(0xff1e1e1e),
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.white60, width: 1.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(
                width: 160.0,
                height: 120.0,
                color: Color(0xff1e1e1e),
                child: FittedBox(
                  child: Image(image: NetworkImage('$j')),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 13.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 1.0, bottom: 0.0),
                    child: Text(
                      ine,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 2.0, bottom: 0.0),
                    child: SingleChildScrollView(
                      child: Text(
                        h,
                        style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.white.withOpacity(0.8),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class siluvai extends StatelessWidget {
  final String tamil;
  final String english;
  final String url;
  final Widget f;
  siluvai({this.english, this.tamil, this.url, this.f});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
      child: Card(
          color: Color(0xff1e1e1e),
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.white60, width: 1.6),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Container(
            height: 60.0,
            width: double.infinity,
            child: Material(
              child: Ink(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('$url'), fit: BoxFit.cover),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return f;
                    }));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                        child: Container(
                            child: Text(
                          tamil,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0),
                        )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                        child: Container(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              english,
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13.0),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}

class KGF {
  final String imageurl;
  final String nameT;
  final String nameE;
  KGF(this.imageurl, this.nameE, this.nameT);
}
