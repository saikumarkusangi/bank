import 'dart:math';

import 'package:bank/controllers/speech_controller.dart';
import 'package:bank/controllers/user_controller.dart';
import 'package:bank/core.dart';
import 'package:bank/views/features/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../constants/colors.dart';
import '../../../constants/images.dart';
import '../../widgets/widgets.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserController>(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  'Profile',
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 38),
                ),
                Divider(
                  color: Colors.grey,
                  thickness: 2,
                ),
                Center(
                    child: AvatarImage(Images.avatars[Random().nextInt(1)],
                        isSVG: false, width: 160, height: 160)),
                SizedBox(
                  width: 15,
                ),
                ListTile(
                  trailing:
                      IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                  title: Text(
                    "Nick Name",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
                  ),
                  subtitle: Text(
                    provider.nickName,
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                ListTile(
                  trailing:
                      IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                  title: Text(
                    "User Name",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
                  ),
                  subtitle: Text(
                    provider.userName,
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                ListTile(
                  trailing:
                      IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                  title: Text(
                    "Full Name",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
                  ),
                  subtitle: Text(
                    provider.fullName,
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                ListTile(
                  trailing:
                      IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                  title: Text(
                    "Mobile",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
                  ),
                  subtitle: Text(
                    provider.phoneNumber,
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                ListTile(
                  trailing:
                      IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                  title: Text(
                    "U p i Id",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
                  ),
                  subtitle: Text(
                    provider.upiId,
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    try {
                      await NetworkServices.deleteUser(
                          provider.nickName.trim());
                      // SpeechController.flutterTts.stop();
                      Get.to(LoginPage());
                    } catch (e) {
                      rethrow;
                    }
                  },
                  child: const Chip(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    label: Text('Delete Account'),
                    labelStyle:
                        TextStyle(color: ThemeColors.secondary, fontSize: 26),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
