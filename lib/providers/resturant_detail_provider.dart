import 'package:flutter/material.dart';
import 'package:local_eat/models/resturant_model.dart';
import 'package:local_eat/network_api.dart';

class ResturantDetailProvider extends ChangeNotifier {
  Resturant _resturant;
  ResturantDetailProvider(Resturant resturant) : _resturant = resturant;

  ApiClient client = apiClient;

  NetworkFailure? _failure;
  NetworkFailure? get failure => _failure;
  setFailure(NetworkFailure failure) {
    _failure = failure;
    print("Setting failure");
    print(_failure.toString());
    notifyListeners();
  }

  setResturant(Resturant resturant) {
    _resturant = resturant;
    notifyListeners();
  }

  Resturant? get resturant => _resturant;

  fetchData() async {}
}
