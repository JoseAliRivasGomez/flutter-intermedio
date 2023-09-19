import 'package:animate_do/animate_do.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:music_player/src/helpers/helpers.dart';
import 'package:music_player/src/models/audioplayer_model.dart';
import 'package:music_player/src/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';


class MusicPlayerPage extends StatelessWidget {
  const MusicPlayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: <Widget>[

          Background(),

          Column(
            children: <Widget>[

              CustomAppBar(),

              ImagenDiscoDuracion(),

              TituloPlay(),

              Expanded(
                child: Lyrics()
              )

            ],
          ),
        ],
      )
   );
  }
}

class Background extends StatelessWidget {
  const Background({super.key});

  @override
  Widget build(BuildContext context) {

    final screenSize = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: screenSize.height * 0.8,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only( bottomLeft: Radius.circular(60)),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.center,
          colors: [
            Color(0xff33333E),
            Color(0xff201E28),
          ]
        )
      ),
    );
  }
}

class Lyrics extends StatelessWidget {
  const Lyrics({super.key});

  @override
  Widget build(BuildContext context) {

    final lyrics = getLyrics();

    return ListWheelScrollView(
      physics: const BouncingScrollPhysics(),
      itemExtent: 42,
      diameterRatio: 1.5,
      children: lyrics.map( 
        (linea) => Text( linea, style: TextStyle( fontSize: 20, color: Colors.white.withOpacity(0.6) ) )
      ).toList()
    );
  }
}

class TituloPlay extends StatefulWidget {
  const TituloPlay({super.key});

  @override
  TituloPlayState createState() => TituloPlayState();
}

class TituloPlayState extends State<TituloPlay> with SingleTickerProviderStateMixin {

  bool isPlaying = false;
  bool firstTime = true;
  late AnimationController playAnimation;


  final assetAudioPlayer = AssetsAudioPlayer();


  @override
  void initState() {
    
    playAnimation = AnimationController( vsync: this, duration: const Duration(milliseconds: 500 ) );
    super.initState();
  }

  @override
  void dispose() { 
    playAnimation.dispose();
    super.dispose();
  }

  void open() {

    final audioPlayerModel = Provider.of<AudioPlayerModel>(context, listen: false);

    //! assetAudioPlayer.open('assets/Breaking-Benjamin-Far-Away.mp3');
    assetAudioPlayer.open(
      Audio('assets/Breaking-Benjamin-Far-Away.mp3'),
      autoStart: true,
      showNotification: true
    );

    assetAudioPlayer.currentPosition.listen( (duration) {
      audioPlayerModel.current = duration;
    });
  
    assetAudioPlayer.current.listen( (playingAudio){
      //! audioPlayerModel.songDuration = playingAudio.duration;
      audioPlayerModel.songDuration = playingAudio?.audio.duration ?? const Duration(seconds: 0);
    });


  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric( horizontal: 50 ),
      margin: const EdgeInsets.only( top: 40 ),
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              Text('Far Away', style: TextStyle( fontSize: 30, color: Colors.white.withOpacity(0.8) )),
              Text('-Breaking Benjamin-', style: TextStyle( fontSize: 15, color: Colors.white.withOpacity(0.5) )),
            ],
          ),

          const Spacer(),

          FloatingActionButton(
            elevation: 0,
            highlightElevation: 0,
            backgroundColor: const Color(0xffF8CB51),
            child: AnimatedIcon(
              icon: AnimatedIcons.play_pause, 
              progress: playAnimation,
            ),
            onPressed: () {

              final audioPlayerModel = Provider.of<AudioPlayerModel>(context, listen: false);
              
              if( isPlaying ) {
                playAnimation.reverse();
                isPlaying = false;
                audioPlayerModel.controller.stop();

              } else {
                playAnimation.forward();
                isPlaying = true;
                audioPlayerModel.controller.repeat();
              }

              if ( firstTime ) {
                open();
                firstTime = false;
              } else {
                assetAudioPlayer.playOrPause();
              }

            },
          )

        ],
      ),
    );
  }
}

class ImagenDiscoDuracion extends StatelessWidget {
  const ImagenDiscoDuracion({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric( horizontal: 30 ),
      margin: const EdgeInsets.only( top: 70 ),
      child: const Row(
        children: <Widget>[

          ImagenDisco(),
          SizedBox( width: 20 ),

          BarraProgreso(),
          SizedBox( width: 20 ),
        ],
      ),
    );
  }
}

class BarraProgreso extends StatelessWidget {
  const BarraProgreso({super.key});
 
  @override
  Widget build(BuildContext context) {

    final estilo = TextStyle( color: Colors.white.withOpacity(0.4) );

    final audioPlayerModel = Provider.of<AudioPlayerModel>(context);
    final porcentaje = audioPlayerModel.porcentaje;

    return Column(
      children: <Widget>[

        Text(audioPlayerModel.songTotalDuration, style: estilo), 
        const SizedBox( height: 10 ),
        Stack(
          children: <Widget>[

            Container(
              width: 3,
              height: 230,
              color: Colors.white.withOpacity(0.1),
            ),

            Positioned(
              bottom: 0,
              child: Container(
                width: 3,
                height: 230 * porcentaje,
                color: Colors.white.withOpacity(0.8),
              ),
            ),

          ],
        ),
        const SizedBox( height: 10 ),
        Text(audioPlayerModel.currentSecond, style: estilo ),
      ],
    );
  }
}

class ImagenDisco extends StatelessWidget {
  const ImagenDisco({super.key});

  @override
  Widget build(BuildContext context) {

    final audioPlayerModel = Provider.of<AudioPlayerModel>(context);

    return Container(
      padding: const EdgeInsets.all(20),
      width: 250,
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(200),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          colors: [
            Color(0xff484750),
            Color(0xff1E1C24),
          ]
        )
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(200),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[

            SpinPerfect(
              duration: const Duration( seconds: 10 ),
              infinite: true,
              manualTrigger: true,
              controller: ( animationController ) => audioPlayerModel.controller = animationController,
              child: const Image( image: AssetImage('assets/aurora.jpg') )
            ),

            Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.circular(100)
              ),
            ),

            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: const Color(0xff1C1C25),
                borderRadius: BorderRadius.circular(100)
              ),
            ),

          ],
        )
      ),
    );
  }
}