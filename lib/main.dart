import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'song_info.dart';
void main() => runApp(MaterialApp(
    theme: ThemeData(
      scaffoldBackgroundColor: Colors.black,
      primaryColor: Colors.green,
    ),
    home: MyApp()));

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final a = AudioCache();
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  var icn = Icons.play_arrow;

  @override
  void initState(){
    super.initState();
    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });
    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }
  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            infoSong(),
            Slider(
              min: 0,
              max: duration.inSeconds.toDouble(),
              value: position.inSeconds.toDouble(),
              thumbColor:  Colors.lightGreenAccent.shade700,
              activeColor: Colors.lightGreenAccent.shade700,
              onChanged: (value) async {
                final position = Duration(seconds: value.toInt());
                await audioPlayer.seek(position);
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text((() {
                    if(position.inSeconds.remainder(60)<10){
                      return "${position.inMinutes.remainder(60)}:0${(position.inSeconds.remainder(60))}";
                    }else{
                      return "${position.inMinutes.remainder(60)}:${(position.inSeconds.remainder(60))}";
                    }
                  })(),
                      style: TextStyle(fontSize: 20, color: Colors.white60)
                  ),
                  Text((() {
                    if((duration-position).inSeconds.remainder(60)<10){
                      return "${(duration-position).inMinutes.remainder(60)}:0${((duration-position).inSeconds.remainder(60))}";
                    }else{
                      return "${(duration-position).inMinutes.remainder(60)}:${((duration-position).inSeconds.remainder(60))}";
                    }
                  })(),
                    style: TextStyle(fontSize: 20, color: Colors.white60),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10,),
              decoration: BoxDecoration(
                  color: Colors.grey.shade700,
                  borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.lightGreenAccent.shade700,
                    child: IconButton(
                        icon: Icon(
                          Icons.fast_rewind,
                        ),
                        iconSize: 15,

                        color: Colors.white,
                        onPressed: () {
                          (() async {
                            if(position.inSeconds<10){
                              await audioPlayer.seek(Duration(seconds: 0));
                            }else{
                              await audioPlayer.seek(Duration(seconds: position.inSeconds.toInt()-10));
                            }
                          })();
                        }
                    ),
                  ),
                  //----------------------------------------------------------------------------
                  CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.lightGreenAccent.shade700,
                    child: IconButton(
                      icon: Icon(
                        icn,
                      ),
                      iconSize: 45,

                      color: Colors.white,
                      onPressed: () async {
                        if(isPlaying){
                          icn = Icons.play_arrow;
                          isPlaying = false;
                          await audioPlayer.pause();
                        }
                        else {
                          icn = Icons.pause;
                          isPlaying = true;
                          audioPlayer.play(AssetSource('RiverFlowsInYou.mp3'));
                        }
                        setState(() {
                          icn;
                        });
                      },
                    ),
                  ),
                  //----------------------------------------------------------------------------
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.lightGreenAccent.shade700,
                    child: IconButton(
                        icon: Icon(
                          Icons.fast_forward,
                        ),
                        iconSize: 15,

                        color: Colors.white,
                        onPressed: () {
                          (() async {
                            if(position.inSeconds+11>duration.inSeconds){
                              await audioPlayer.seek(Duration(seconds: duration.inSeconds.toInt()));
                            }else{
                              await audioPlayer.seek(Duration(seconds: position.inSeconds.toInt()+10));
                            }
                          })();
                        }
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}