import 'package:flutter/material.dart';
import 'package:local_eat/models/resturant_model.dart';
import 'package:local_eat/network_api.dart';
import 'package:local_eat/providers/states.dart';

class ResturantsProvider extends ChangeNotifier {
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

  List<Resturant> _resturants = [];
  List<Resturant> get resturants => _resturants;
  setResturants(List<Resturant> resturants) {
    _resturants = resturants;
    notifyListeners();
  }

  fetchData() async {
    setState(EnumProviderState.loading);

    try {
      List<Resturant> resturants = await client.fetchResturants();
      setResturants(resturants);
    } on NetworkFailure catch (e) {
      setFailure(e);
      setState(EnumProviderState.loaded);
      return;
    }

    setState(EnumProviderState.loaded);
  }
}
