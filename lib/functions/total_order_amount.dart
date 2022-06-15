import 'package:flutter/material.dart';

class TotalOrderAmount extends ChangeNotifier {
  double _totalAmount = 0;

  double get tAmount => _totalAmount;

  displayTotalAmount(double amount) async {
    _totalAmount = amount;
    await Future.delayed(const Duration(microseconds: 100), () {
      notifyListeners();
    });
  }
}
