import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:local_eat/models/groceries_model.dart';
import 'package:local_eat/network_api.dart';
import 'package:local_eat/providers/states.dart';

class GroceriesProvider extends ChangeNotifier {
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

  List<Groceries> _groceries = [];
  List<Groceries> get groceries => _groceries;
  setGroceries(List<Groceries> groceries) {
    _groceries = groceries;
    notifyListeners();
  }

  fetchData() async {
    setState(EnumProviderState.loading);

    try {
      List<Groceries> groceries = await client.fetchGroceris();
      setGroceries(groceries);
    } on NetworkFailure catch (e) {
      setFailure(e);
      setState(EnumProviderState.loaded);
      return;
    }

    setState(EnumProviderState.loaded);
  }
}
