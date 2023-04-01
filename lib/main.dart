import 'dart:io';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:bank/controllers/controllers.dart';
import 'package:bank/controllers/history_controller.dart';
import 'package:bank/controllers/mic_controller.dart';
import 'package:bank/controllers/user_controller.dart';
import 'package:bank/services/network_services.dart';
import 'package:bank/views/features/first/first_page.dart';
import 'package:bank/views/features/home/home.dart';
import 'package:bank/views/features/login/login_page.dart';
import 'package:bank/views/views.dart';
import 'package:bank/views/widgets/demo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'localStringgs/localStrings.dart.dart';
import 'views/widgets/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
   // SpeechController.listen('Hello how can i help you');
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MicController>(
            create: (context) => MicController()),
        ChangeNotifierProvider<UserController>(
            create: (context) => UserController()),
             ChangeNotifierProvider<HistoryController>(
            create: (context) => HistoryController()),
      ],
      child: GetMaterialApp(
        translations: LocalString(),
        locale: const Locale('te','IN'),
        builder: (context, child) {
          return ScrollConfiguration(behavior: MyBehaviour(), child: child!);
        },
        title: 'Hdfc smart app',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          floatingActionButtonTheme:
              const FloatingActionButtonThemeData(backgroundColor: Colors.red),
          primarySwatch: Colors.blue,
        ),
        home:const FirstPage(),
      ),
    );
  }
}

class MyBehaviour extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

