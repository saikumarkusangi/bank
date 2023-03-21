import 'dart:math';

import 'package:flutter/material.dart';

import '../../constants/images.dart';
import 'avatar_image.dart';

class UserBox extends StatelessWidget {
  UserBox(
      {Key? key,
      required this.user,
      this.isSVG = false,
      this.width = 55,
      this.height = 55})
      : super(key: key);
  final user;
  double width;
  double height;
  bool isSVG;

  @override
  Widget build(BuildContext context) {
    print(user);
    return Column(
      children: [
        AvatarImage(Images.avatars[Random().nextInt(4)],
          isSVG: isSVG, width: width, height: height,
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          user["to-from"],
          style: TextStyle(fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}
