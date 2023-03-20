import 'package:flutter/material.dart';

import '../../widgets/widgets.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    
    return  Scaffold(
    appBar: AppBar(
    title: const Text("Profile"),
    actions: const [],
    ),
    body: SingleChildScrollView(
    child: Container(
    padding: const EdgeInsets.all(10.0),
    child: Column(
    children: const [],
    ),
    ),
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
floatingActionButton: const Mic(),
    );
  }
}