import 'dart:io';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:bank/controllers/controllers.dart';
import 'package:bank/controllers/mic_controller.dart';
import 'package:bank/services/network_services.dart';
import 'package:bank/views/features/login/login_page.dart';
import 'package:bank/views/views.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import 'views/widgets/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SpeechController.listen('శుభోదయం నేను మీకు ఎలా సహాయం చేయగలను');
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MicController>(
            create: (context) => MicController()),
      
      ],
      child: GetMaterialApp(
        builder: (context,child){
          return ScrollConfiguration(
            behavior: MyBehaviour(),
             child: child!);
        },
        title: 'Hdfc smart app',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: Colors.red),
          primarySwatch: Colors.blue,
        ),
        home:  LoginPage(),
      ),
    );
  }
}

class MyBehaviour extends ScrollBehavior{
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,Widget child,ScrollableDetails details){
      return child;
    }
  
}