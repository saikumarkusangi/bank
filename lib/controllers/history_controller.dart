import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../services/network_services.dart';

class HistoryController extends ChangeNotifier {
  List<Map<String, dynamic>> history = [];
  bool balance = false;

  void showBalance(val) {
    balance = val;
    notifyListeners();
    Timer(const Duration(seconds: 5), () {
      balance = false;
      notifyListeners();
    });
  }

  HistoryController() {
    transactions();
  }

  Future<dynamic> transactions() async {
    print("Transactions loading");
    notifyListeners();
    final response = await NetworkServices.history('sandeep');
    notifyListeners();
    response.toString().split('}').map((e) {
      //  print("%%%%%%%%%%%%%%%%%%%%%%%" + e.split(':')[7].split(',')[0].replaceAll(RegExp("'"), ''));
      history.add({
        "date": e.split(':')[2].split(',')[0].replaceAll(RegExp("'"), ''),
        "time": e.split(':')[3].replaceAll(RegExp("'"), "") +
            ":" +
            e.split(':')[4].replaceAll(RegExp("'"), ""),
        "to-from": e.split(':')[6].split(',')[0].replaceAll(RegExp("'"), ''),
        "amount": e.split(':')[7].split(',')[0].replaceAll(RegExp("'"), ''),
        "balance": e.split(':')[8].split(',')[0].replaceAll(RegExp("'"), '')
      });
    }).toList();

    return response.toString().split(',')[0].split(',');
  }
}
