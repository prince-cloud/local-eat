import 'package:flutter/material.dart';
import 'package:local_eat/models/grocery_shop_model.dart';
import 'package:local_eat/models/resturant_model.dart';
import 'package:local_eat/network_api.dart';
import 'package:local_eat/providers/states.dart';

class GroceryShopProvider extends ChangeNotifier {
  ApiClient client = apiClient;

  EnumProviderState _state = EnumProviderState.initial;
  EnumProviderState get state => _state;
  setState(EnumProviderState state) {
    _state = state;
    notifyListeners();
  }

  NetworkFailure? _failure;
  NetworkFailure? get failure => _failure;
  setFailure(NetworkFailure failure) {
    _failure = failure;
    notifyListeners();
  }

  List<GroceryShop> _groceryShop = [];
  List<GroceryShop> get groceryShop => _groceryShop;
  setGroceryShops(List<GroceryShop> groceryShop) {
    _groceryShop = groceryShop;
    notifyListeners();
  }

  fetchData() async {
    setState(EnumProviderState.loading);

    try {
      List<GroceryShop> groceryShop = await client.fetchGroceryShops();
      setGroceryShops(groceryShop);
    } on NetworkFailure catch (e) {
      setFailure(e);
      setState(EnumProviderState.loaded);
      return;
    }

    setState(EnumProviderState.loaded);
  }
}
