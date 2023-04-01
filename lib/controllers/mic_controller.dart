import 'dart:async';

import 'package:bank/controllers/controllers.dart';
import 'package:bank/controllers/user_controller.dart';
import 'package:bank/views/features/home/home_page.dart';
import 'package:bank/views/features/login/login_page.dart';
import 'package:bank/views/features/profile/profile_page.dart';
import 'package:bank/views/features/send/send_page.dart';
import 'package:bank/views/views.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../views/features/home/home.dart';

class MicController extends ChangeNotifier {
  List _text = [];
  bool _isListening = false;
  bool notFound = true;
  bool get isListening => _isListening;
  List get text => _text;
  bool _bottomSheet = false;
  bool bottomSheet = true;

  showButtomSheet() {
    _bottomSheet = true;
    notifyListeners();
  }

  listening(bool value) {
    _isListening = value;
    notifyListeners();
  }

  listen() async {
    // _isListening = true;

    // notifyListeners();
    print(_text.toString());
    _text.map((e) {
      if (Commands.checkBalanceCommand.contains(e.toString().trim())) {
        notFound = false;
        notifyListeners();
        SpeechController.listen('మీ పిన్‌ను నమోదు చేయండి');
        _text.clear();
        _isListening = false;
        print(_bottomSheet);
        
        notifyListeners();
        Timer(Duration(seconds: 3), () {
          showButtomSheet();
        });
        _text.clear();
        notifyListeners();
      }

      if (Commands.sendCommand.contains(e.toString().trim())) {
        notFound = false;
        notifyListeners();
        SpeechController.listen('డబ్బు పంపే పేజీకి వెళుతోంది');
        _text.clear();
        _isListening = false;
        print(_bottomSheet);
        showButtomSheet();
        notifyListeners();
        Timer(Duration(seconds: 3), () {
          Get.to(const SendPage(),transition: Transition.cupertino,
                    duration: const Duration(milliseconds: 200));
        });
        _text.clear();
        notifyListeners();
      }

      if (Commands.loginPageCommand.contains(e)) {
        notFound = false;
        notifyListeners();
        SpeechController.listen('లాగిన్ పేజీకి వెళుతోంది');
        _text.clear();
        _isListening = false;
        notifyListeners();
        Timer(Duration(seconds: 3), () {
          Get.to(LoginPage(),transition: Transition.cupertino,
                    duration: const Duration(milliseconds: 200));
        });
        _text.clear();
        notifyListeners();
      }
      if (Commands.backPageCommand.contains(e)) {
        notFound = false;
        notifyListeners();
        SpeechController.listen('వెనుక పేజీకి వెళుతున్నాను');
        _text.clear();
        _isListening = false;
        notifyListeners();
        Timer(Duration(seconds: 3), () {
          Get.back();
        });
        _text.clear();
        notifyListeners();
      }
      if (Commands.signUpPageCommand.contains(e)) {
        notFound = false;
        notifyListeners();
        SpeechController.listen('నమోదు పేజీకి వెళుతోంది');
        _text.clear();
        _isListening = false;
        notifyListeners();
        Timer(Duration(seconds: 3), () {
          Get.to(const SignUpPage(),transition: Transition.cupertino,
                    duration: const Duration(milliseconds: 200));
        });
        _text.clear();
        notifyListeners();
      }

      if (Commands.homePageCommand.contains(e)) {
        notFound = false;
        notifyListeners();
        SpeechController.listen('హోమ్ పేజీకి వెళుతోంది');
        print(_text);

        _text.clear();
        print(_text);
        _isListening = false;
        notifyListeners();
        Timer(Duration(seconds: 3), () {
          Get.to(const Home(),transition: Transition.cupertino,
                    duration: const Duration(milliseconds: 200));
        });
        _text.clear();
        notifyListeners();
      }
      if (Commands.profilePageCommand.contains(e)) {
        notFound = false;
        notifyListeners();
        SpeechController.listen('ప్రొఫైల్ పేజీకి వెళుతున్నాను');
        print(_text);

        _text.clear();
        print(_text);
        _isListening = false;
        notifyListeners();
        Timer(Duration(seconds: 3), () {
          Get.to(const ProfilePage(),transition: Transition.cupertino,
                    duration: const Duration(milliseconds: 200));
        });
      }

      if (notFound) {
        SpeechController.listen(
            'క్షమించండి ఆదేశం గుర్తించబడలేదు మళ్లీ ప్రయత్నించండి');
        print(_text);
        _text.clear();
        print(_text);
        _isListening = false;
        notifyListeners();
      }

      // if(notFound){
      //"క్షమించండి ఆదేశం గుర్తించబడలేదు మళ్లీ ప్రయత్నించండి"
      //   SpeechController.listen('Sorry command not recognized try again');
      //   _text.clear();
      //   _isListening = false;
      //   notifyListeners();
      // }
    }).toList();
    _text.clear();
  }
}
