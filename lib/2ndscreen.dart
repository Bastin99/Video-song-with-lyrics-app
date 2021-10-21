import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'selectionDraw.dart';

class SecondScreen extends StatefulWidget {
  final String id;

  final String dop;
  SecondScreen({this.id, this.dop});
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  String h;
  double d;
  bool g = true;
  int a;
  Future<List> getper() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var name = preferences.getDouble('size');
    setState(() {
      d = name;
    });
    List a = [];
    var j = preferences.getBool('l');
    a.add(j);
    var o = preferences.getBool('p');
    a.add(o);
    return a;
  }

  bool _isPlayerReady = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  YoutubePlayerController _controller;
  TextEditingController _idController;
  TextEditingController _seekToController;

  PlayerState _playerState;
  YoutubeMetaData _videoMetaData;
  @override
  void initState() {
    super.initState();
    getper().then((value) {
      _controller = YoutubePlayerController(
        initialVideoId: widget.id,
        flags: YoutubePlayerFlags(
          mute: false,
          autoPlay: value[0] == null ? true : value[0],
          forceHD: value[1] == null ? false : value[1],
        ),
      )..addListener(() {
          _idController = TextEditingController();
          _seekToController = TextEditingController();
          _videoMetaData = const YoutubeMetaData();
          _playerState = PlayerState.unknown;
        });
    });

    print(widget.id);
    h = widget.dop;
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0Xff3a434c),
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 30.0),
            child: IconButton(
                icon: Icon(
                  Icons.settings,
                  size: 25.0,
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return Settingg();
                  }));
                }),
          )
        ],
        elevation: 30.0,
        backgroundColor: Colors.black87,
        title: Text(''),
      ),
      body: widget.id != 'not available'
          ? Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Hero(
                    tag: 'k',
                    child: YoutubePlayer(
                      progressIndicatorColor: Colors.redAccent,
                      progressColors:
                          ProgressBarColors(handleColor: Colors.redAccent),
                      liveUIColor: Colors.redAccent,
                      controller: _controller,
                      showVideoProgressIndicator: true,
                      onReady: () {
                        print('Player is ready.');
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: SingleChildScrollView(
                      physics: ClampingScrollPhysics(),
                      child: h != null
                          ? Container(
                              padding: EdgeInsets.all(8),
                              child: Card(
                                elevation: 70.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                color: Colors.white.withOpacity(0.6),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    '${h.replaceAll("\\n", "\n")}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black.withOpacity(0.9),
                                      fontSize: d == null ? 15.0 : d,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Container()),
                ),
              ],
            )
          : Container(
              height: double.infinity,
              padding: EdgeInsets.all(3),
              child: Card(
                elevation: 70.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                color: Colors.white.withOpacity(0.8),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SingleChildScrollView(
                    child: Text(
                      '${h.replaceAll("\\n", "\n")}',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black.withOpacity(0.9),
                        fontSize: d == null ? 15.0 : d,
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
