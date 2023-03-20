import 'dart:async';

import 'package:bank/controllers/controllers.dart';
import 'package:bank/views/features/home/home_page.dart';
import 'package:bank/views/features/login/login_page.dart';
import 'package:bank/views/features/profile/profile_page.dart';
import 'package:bank/views/views.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/constants.dart';

class MicController extends ChangeNotifier {
   List _text = [];
  bool _isListening = false;
   bool _notFound = false;
  bool get notFound => _notFound;
  bool get isListening => _isListening;
  List get text => _text;

  listening(bool value) {
    _isListening = value;
    notifyListeners();
  }

 

  listen() async {
    _isListening = true;
   
    notifyListeners();
      print(_text.toString());
    _text.map((e) {
    
      if (Commands.loginPageCommand.contains(e)) {
        SpeechController.listen('లాగిన్ పేజీకి వెళుతోంది');
        _text.clear();
        _isListening = false;
        notifyListeners();
        Timer(Duration(seconds: 3),
         () {  Get.to(const LoginPage());});
         _text.clear();
         notifyListeners();
        
        
      }
       if (Commands.backPageCommand.contains(e)) {
        SpeechController.listen('వెనుక పేజీకి వెళుతున్నాను');
        _text.clear();
        _isListening = false;
        notifyListeners();
        Timer(Duration(seconds: 3),
         () {  Get.back();});
         _text.clear();
         notifyListeners();
        
        
      }
      if (Commands.signUpPageCommand.contains(e)) {
        SpeechController.listen('నమోదు పేజీకి వెళుతోంది');
        _text.clear();
        _isListening = false;
        notifyListeners();
        Timer(Duration(seconds: 3),
         () {  Get.to(const SignUpPage());});
         _text.clear();
         notifyListeners();
        
        
      }
      
       if (Commands.homePageCommand.contains(e)) {
        SpeechController.listen('హోమ్ పేజీకి వెళుతోంది');
        print(_text);
       
        _text.clear();
        print(_text);
        _isListening = false;
        notifyListeners();
        Timer(Duration(seconds: 3),
         () {  Get.to(const HomePage());});
         _text.clear();
         notifyListeners();
      }
       if (Commands.profilePageCommand.contains(e)) {
        SpeechController.listen('ప్రొఫైల్ పేజీకి వెళుతున్నాను');
        print(_text);
       
        _text.clear();
        print(_text);
        _isListening = false;
        notifyListeners();
        Timer(Duration(seconds: 3),
         () {  Get.to(const ProfilePage());});
         _text.clear();
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
