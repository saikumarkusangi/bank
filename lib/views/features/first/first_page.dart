import 'package:avatar_glow/avatar_glow.dart';
import 'package:bank/constants/constants.dart';
import 'package:bank/controllers/controllers.dart';
import 'package:bank/controllers/user_controller.dart';
import 'package:bank/core.dart';
import 'package:bank/views/features/home/home.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import '../../views.dart';
import '../../widgets/widgets.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  static var int = 0;
  @override
  Widget build(BuildContext context) {
    if (int == 0) {
      SpeechController.listen("please Select your langauge");
      setState(() {
        int = 1;;
      });
    }

    return Scaffold(
      backgroundColor: ThemeColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Image.asset(Images.loginbanner)),
              ),
              const SizedBox(
                height: 100,
              ),
              const Text(
                'Select your langauge',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 32),
              ),
              const SizedBox(
                height: 100,
              ),
              InkWell(
                onTap: () {
                  var english = Locale('en', 'US');
                  Get.updateLocale(english);
                  Get.to(const LoginPage(),
                      duration: const Duration(
                        milliseconds: 300,
                      ),
                      transition: Transition.cupertino);
                },
                child: const Chip(
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  label: Text('English'),
                  labelStyle:
                      TextStyle(color: ThemeColors.background, fontSize: 26),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              InkWell(
                onTap: () {
                  var telugu = const Locale('te', 'IN');
                  Get.updateLocale(telugu);
                  Get.to(const LoginPage(),
                      duration: const Duration(
                        milliseconds: 300,
                      ),
                      transition: Transition.cupertino);
                },
                child: const Chip(
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  label: Text('Telugu'),
                  labelStyle:
                      TextStyle(color: ThemeColors.background, fontSize: 26),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const Mic(),
    );
  }
}
