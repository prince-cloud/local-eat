import 'package:flutter/cupertino.dart';
import 'package:local_eat/global.dart';

class CartItemCounter extends ChangeNotifier {
  int cartItemCounter =
      sharedPreferences!.getStringList("userCart")!.length - 1;
  int get count => cartItemCounter;

  Future<void> displayCartItemCounter() async {
    cartItemCounter = sharedPreferences!.getStringList("userCart")!.length - 1;

    await Future.delayed(const Duration(milliseconds: 100), () {
      notifyListeners();
    });
  }
}
