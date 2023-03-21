import 'dart:convert';

import 'package:bank/models/user_model.dart';
import 'package:bank/services/network_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserController extends ChangeNotifier {
  bool isLoading = false;
  List userdata = [];
  String nickName = '';
  String userName = '';
  String fullName = '';
  String phoneNumber = '';
  String pinNumber = '';
  String upiId = '';
  String currentBalance = '';
  List<Map<String, dynamic>> history = [];

  UserController() {
    userdatafetch();
    send(to: '', ammount: 0, from: '');
    transactions();
  }

  Future<dynamic> transactions() async {
    isLoading = true;
    notifyListeners();
    final response = await NetworkServices.history('sandeep');
    isLoading = false;
    notifyListeners();

    response.toString().split('}').map((e) {
      //  print("%%%%%%%%%%%%%%%%%%%%%%%" + e.split(':')[3].replaceAll(RegExp("'"),""));
      history.add({
        "date": e.split(':')[2].split(',')[0].replaceAll(RegExp("'"), ''),
        "time": e.split(':')[3].replaceAll(RegExp("'"), "")+":"+e.split(':')[4].replaceAll(RegExp("'"), ""),
        "to-from": e.split(':')[6].split(',')[0].replaceAll(RegExp("'"), ''),
        "amount": e.split(':')[7].split(',')[0].replaceAll(RegExp("'"), ''),
        "balance": e.split(':')[8].split(',')[0].replaceAll(RegExp("'"), '')
      });
    }).toList();

    return response.toString().split(',')[0].split(',');
  }

  Future<String> send(
      {required String to, required int ammount, required String from}) async {
    isLoading = true;
    notifyListeners();
    final response = await NetworkServices.send(to, ammount, from);
    isLoading = false;
    notifyListeners();

    print(response + '###################');
    return response
        .toString()
        .split(':')[1]
        .replaceAll(RegExp("'"), '')
        .substring(
            0,
            response
                    .toString()
                    .split(':')[1]
                    .replaceAll(RegExp("'"), '')
                    .length -
                1);
  }

  Future<void> userdatafetch() async {
    isLoading = true;
    notifyListeners();
    final data = await NetworkServices.userlogin('sandeep');

    isLoading = false;
    notifyListeners();
    print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@000');
    userdata = data.split(',');
    print(userdata);

    nickName = userdata[1].toString().split(':')[1].replaceAll(RegExp("'"), '');
    fullName = userdata[2].toString().split(':')[1].replaceAll(RegExp("'"), '');
    userName = userdata[3].toString().split(':')[1].replaceAll(RegExp("'"), '');
    pinNumber =
        userdata[4].toString().split(':')[1].replaceAll(RegExp("'"), '');
    phoneNumber =
        userdata[5].toString().split(':')[1].replaceAll(RegExp("'"), '');
    upiId = userdata[6]
        .toString()
        .split(':')[1]
        .replaceAll(RegExp("'"), '')
        .substring(
            0,
            userdata[6]
                    .toString()
                    .split(':')[1]
                    .replaceAll(RegExp("'"), '')
                    .length -
                1);

    notifyListeners();
    final Balance = await NetworkServices.currentBalance(nickName);
    print(Balance);
    currentBalance = Balance.toString()
        .split(':')[1]
        .substring(0, Balance.toString().split(':')[1].length - 3);
    notifyListeners();
  }
}
