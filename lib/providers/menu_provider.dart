import 'package:flutter/material.dart';
import 'package:local_eat/models/food_menu_models.dart';
import 'package:local_eat/network_api.dart';

class MenuFoodProvider extends ChangeNotifier {
  FoodMenu _menuFoods;
  MenuFoodProvider(FoodMenu menuFoods) : _menuFoods = menuFoods;

  ApiClient client = apiClient;

  NetworkFailure? _failure;
  NetworkFailure? get failure => _failure;
  setFailure(NetworkFailure failure) {
    _failure = failure;
    print("Setting failure");
    print(_failure.toString());
    notifyListeners();
  }

  setmenuFoods(FoodMenu menuFoods) {
    _menuFoods = menuFoods;
    notifyListeners();
  }

  FoodMenu? get menuFoods => _menuFoods;

  fetchData() async {}
}
