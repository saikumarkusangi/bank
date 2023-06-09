import 'dart:convert';

import 'package:bank/models/user_model.dart';
import 'package:bank/services/constants.dart';
import 'package:bank/views/features/record/record_page.dart';
import 'package:bank/views/widgets/user_box.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NetworkServices {
  static userlogin<UserData>(String nickName, String pinNumber) async {
    try {
      final response = await http.post(
        Uri.parse(ApiKey.url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(
          {"action": "details", "nick_name": nickName},
        ),
      );

      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      rethrow;
    }
  }

  static createAccount<UserData>(
    String nickName,
    String fullName,
    String pin,
    String mobile,
    String upi,
    String userName,
  ) async {
    try {
      final response = await http.post(
        Uri.parse(ApiKey.url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "action": "register",
          "nick_name": nickName,
          "full_name": fullName,
          "user_name": userName,
          "pin_number": pin,
          "mob_number": mobile,
          "upi_id": "$upi@rpbank"
        }),
      );

      if (response.statusCode == 200) {
        print(response.body);
        return response.body;
      }
    } catch (e) {
      rethrow;
    }
  }

  static deleteUser<UserData>(String nickName) async {
    try {
      final response = await http.post(
        Uri.parse(ApiKey.url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"action": "remove", "nick_name": nickName}),
      );

      if (response.statusCode == 200) {
        print(response.body);
        return response.body;
      }
    } catch (e) {
      rethrow;
    }
  }

  static currentBalance<UserData>(String nickName) async {
    try {
      final response = await http.post(
        Uri.parse(ApiKey.url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(
          {"action": "balance", "nick_name": "sandeep"},
        ),
      );

      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      rethrow;
    }
  }

  static send<UserData>(String to, int ammount, String from) async {
    try {
      final response = await http.post(
        Uri.parse(ApiKey.url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(
          {
            "action": "transfer",
            "amount": ammount,
            "from_user": from,
            "to_user": to
          },
        ),
      );

      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      rethrow;
    }
  }

  static history<UserData>(String nickName) async {
    try {
      final response = await http.post(
        Uri.parse(ApiKey.url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(
          {"action": "history", "nick_name": nickName},
        ),
      );

      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      rethrow;
    }
  }
}
