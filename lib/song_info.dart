import 'package:flutter/material.dart';
class infoSong extends StatefulWidget {
  const infoSong({Key? key}) : super(key: key);

  @override
  State<infoSong> createState() => _infoSongState();
}

class _infoSongState extends State<infoSong> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 50),
        ClipRect(
            child: new Image.asset('assets/space_bg.png',
              width: double.infinity,
              height: 350,
              fit: BoxFit.cover,)
        ),
        const SizedBox(height: 10,),
        const Text('The River Flows In You',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4,),
        const Text('-Yiruma',
          style: TextStyle(fontSize: 20, color: Colors.white60),
        ),
      ],
    );
  }
}
