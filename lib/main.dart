import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'mainPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:after_layout/after_layout.dart';
import 'package:introduction_screen/introduction_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          hintColor: Colors.white,
          cursorColor: Colors.white,
          canvasColor: Color(0xff303030),
          textTheme: TextTheme(
            title: TextStyle(
                color: Colors.white,
                fontSize: 18,
                decorationColor: Colors.white),
          ),
          scaffoldBackgroundColor: Color(0xff1f2933)),
      home: Splash(),
    );
  }
}

class Splash extends StatefulWidget {
  @override
  SplashState createState() => new SplashState();
}

class SplashState extends State<Splash> with AfterLayoutMixin<Splash> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new Home()));
    } else {
      await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new IntroScreen()));
    }
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.black,
      body: Center(
          child: Image(
        image: AssetImage('images/ic.png'),
      )),
    );
  }
}

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: "Hi,there! ",
          body: "வரவேற்கிறோம்!",
          image: Image(image: AssetImage('images/Group 1.png')),
          decoration: PageDecoration(
            titleTextStyle: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
                color: Colors.white),
            bodyTextStyle: TextStyle(
                fontSize: 19.0,
                color: Colors.white.withOpacity(0.8),
                fontWeight: FontWeight.bold),
            descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
            pageColor: Color(0xff8a63b3),
            imagePadding: EdgeInsets.all(55),
          ),
        ),
        PageViewModel(
          title: "Find your songs with easy search ",
          body: "சுலபமான பாடல் தேடல் வசதி ",
          image: Image(image: AssetImage('images/Group 5.png')),
          decoration: PageDecoration(
            titleTextStyle: TextStyle(
                fontSize: 23.0,
                fontWeight: FontWeight.w700,
                color: Colors.white),
            bodyTextStyle: TextStyle(
                fontSize: 19.0,
                color: Colors.white.withOpacity(0.8),
                fontWeight: FontWeight.bold),
            descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
            pageColor: Color(0xfff43757),
            imagePadding: EdgeInsets.all(55),
          ),
        ),
        PageViewModel(
          title: "Songs with lyrics \n\n பாடல்கள்... வரிகளுடன்...",
          body: "*Not all songs contains lyrics",
          image: Image(image: AssetImage('images/mobile-app.png')),
          decoration: PageDecoration(
            titleTextStyle: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.w700,
                color: Colors.white),
            bodyTextStyle: TextStyle(fontSize: 9.0),
            descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
            pageColor: Color(0xff3c97e9),
            imagePadding: EdgeInsets.all(25),
          ),
        )
      ],
      onDone: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return Home();
        }));
      },
      onSkip: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return Home();
        }));
      },
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: const Text(
        'Skip',
        style: TextStyle(color: Color(0xfffec83b), fontSize: 18.0),
      ),
      next: const Icon(
        Icons.arrow_forward_rounded,
        color: Color(0xfffec83b),
        size: 30.0,
      ),
      done: const Text('Done',
          style:
              TextStyle(fontWeight: FontWeight.w600, color: Color(0xfffec83b))),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeColor: Colors.white,
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
