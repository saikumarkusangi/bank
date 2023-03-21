import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class Demo extends StatefulWidget {
  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  final stt.SpeechToText speech = stt.SpeechToText();
  TextEditingController _textEditingController = TextEditingController();
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    initSpeechRecognizer();
  }

  Future<void> initSpeechRecognizer() async {
    bool isAvailable = await speech.initialize(
        onStatus: (status) => print('Speech recognizer status: $status'),
        onError: (error) => print('Speech recognizer error: $error'));

    if (isAvailable) {
      print('Speech recognizer initialized');
    } else {
      print('Speech recognizer not available');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Voice Recognition TextField'),
        ),
        body: Column(
          children: [
            (_isListening) ? Text('listening') : Text('not listenij g'),
            TextField(
              decoration: InputDecoration(
                hintText: 'Type here or press the mic button',
              ),
              controller: _textEditingController,
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (speech.isAvailable) {
              print('avilabel');

              try {
                bool spk = await speech.listen();
                print(spk);
                speech.listen(
                  onResult: (res) {
                    print('object');
                    print(res.recognizedWords);
                    setState(() {
                      _textEditingController.text = res.recognizedWords;
                    });
                  },
                );
              } catch (e) {
                print(e);
              }
            }
          },
          child: Icon(_isListening ? Icons.stop : Icons.mic),
        ),
      ),
    );
  }
}
