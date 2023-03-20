import 'dart:async';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:bank/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../../controllers/mic_controller.dart';
class Mic extends StatefulWidget {
const Mic({Key? key}) : super(key: key);

  @override
  State<Mic> createState() => _MicState();
}

class _MicState extends State<Mic> {
  late stt.SpeechToText _speech;
  final FlutterTts flutterTts = FlutterTts();
  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }
@override
 
  @override
  Widget build(BuildContext context) {
    
    final micProvider = Provider.of<MicController>(context);
    
    return AvatarGlow(
      animate: micProvider.isListening,
      glowColor: Colors.red,
      endRadius: 100,
      showTwoGlows: true,
      duration: const Duration(milliseconds: 800),
      repeat: true,
      child: GestureDetector(
        onLongPress: () async {
          
          if (!micProvider.isListening ) {
            if (micProvider.text.isNotEmpty) {
              micProvider.listen();
            }
            bool available = await _speech.initialize(
              onStatus: (val) => print('onStatus : $val'),
              onError: (val) => print('onError : $val'),
            );
            if (available) {
              
                print('listening');
               micProvider.listening(true);
                _speech.listen(onResult: (val) async {
                 micProvider.text.add(val.recognizedWords);
               
                  
                 
              
              });
               Timer(Duration(seconds :3),(){
                     print('stopping');
                  
                 micProvider.listening(false);
                    
                  _speech.stop();
                });
            
            } else {
             print('off');
              setState(() {
               micProvider.listening(false);
                _speech.stop();
              });
            }
          }
        },
        onLongPressCancel: (){
             if (!micProvider.isListening ) {
          if (micProvider.text.isNotEmpty) {
              micProvider.listen();
            }}
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Container(
            width: 70,
            height: 70,
            decoration: const BoxDecoration(color: Colors.red),
            child: Icon(micProvider.isListening
             ? Icons.mic : Icons.mic_none,color: Colors.white,size: 38,
             )),
        ),
      ),
    );
  }
}