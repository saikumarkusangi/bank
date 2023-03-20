import 'dart:convert';

import 'package:bank/models/user_model.dart';
import 'package:bank/services/constants.dart';
import 'package:bank/views/features/record/record_page.dart';
import 'package:bank/views/widgets/user_box.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NetworkServices {
  static sendMoney() async {
    try {
      final response = await http.post(
        Uri.parse(ApiKey.url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(
          {
            "action": "transfer",
            "amount": 100,
            "from_user": "sandeep",
            "to_user": "irfan"
          },
        ),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
      }
    } catch (e) {
      rethrow;
    }
  }

  static userlogin<UserData>(String nickName) async {
    try {
      print('input'+nickName);
      final response = await http.post(
        Uri.parse(ApiKey.url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(
          {"action": "details", "nick_name": nickName},
        ),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
        return response.body[5];
      }
    } catch (e) {
      rethrow;
    }
  }
}
