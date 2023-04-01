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
  

  UserController() {
    userdatafetch('', '');
    send(to: '', ammount: 0, from: '');
  }

  Future<String> send(
      {required String to, required int ammount, required String from}) async {
    isLoading = true;
    notifyListeners();
    final response = await NetworkServices.send(to, ammount, from);
    isLoading = false;
    notifyListeners();
    return response.toString();
  }

  Future<void> userdatafetch(fnickName, fpinNumber) async {
    isLoading = true;
    notifyListeners();
    final data = await NetworkServices.userlogin(fnickName, fpinNumber);
    print("&&&&&&"+data);
    isLoading = false;
    notifyListeners();
    
    userdata = data.split(',');

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
    currentBalance = Balance.toString()
        .split(':')[1]
        .substring(0, Balance.toString().split(':')[1].length - 3);
    notifyListeners();
  }
}
