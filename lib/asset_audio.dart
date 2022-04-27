import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

class AssetAudio extends StatefulWidget {
  const AssetAudio({Key? key}) : super(key: key);

  @override
  State<AssetAudio> createState() => _AssetAudioState();
}

class _AssetAudioState extends State<AssetAudio> {
  final AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();

  String? time;
  String? position;

  double timeinseconds = 0;
  double positioninseconds = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    assetsAudioPlayer.open(
      Playlist(
        audios: [
          Audio('assets/Forest_sound.mp3'),
          Audio('assets/Heart beat sound.mp3'),
          Audio('assets/Rain and storm_sound.mp3'),
        ],
      ),
      autoStart: false,
    );

    assetsAudioPlayer.current.listen((Playing? playing) {
      setState(() {
        time = playing!.audio.duration.toString().split(".")[0];
        timeinseconds = playing.audio.duration.inSeconds.toDouble();
      });
    });

    assetsAudioPlayer.currentPosition.listen((Duration duration) {
      setState(() {
        position = duration.toString().split(".")[0];
        positioninseconds = duration.inSeconds.toDouble();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Asset Audio"),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: const Icon(Icons.skip_previous),
                  onPressed: ()  {
                    assetsAudioPlayer.previous();
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.play_arrow_rounded),
                  onPressed: () async {
                    await assetsAudioPlayer.play();
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.pause),
                  onPressed: () async {
                    await assetsAudioPlayer.pause();
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.stop),
                  onPressed: () async {
                    await assetsAudioPlayer.stop();
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.skip_next),
                  onPressed: ()  {
                    assetsAudioPlayer.next();
                  },
                ),
              ],
            ),
            Slider(
              value: positioninseconds,
              min: 0,
              max: timeinseconds,
              onChanged: (val) {
                setState(() {
                  positioninseconds = val;
                  assetsAudioPlayer.seek(
                    Duration(
                      seconds: val.toInt(),
                    ),
                  );
                });
              },
            ),
            Text(
              "$position / $time",
              style: const TextStyle(
                fontSize: 22,
              ),
            )
          ],
        ),
      ),
    );
  }
}
