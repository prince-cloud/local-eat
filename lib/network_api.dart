import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:local_eat/models/food_menu_models.dart';
import 'package:local_eat/models/food_model.dart';
import 'package:local_eat/models/groceries_model.dart';
import 'package:local_eat/models/resturant_model.dart';

class NetworkFailure {
  String _message;
  NetworkFailure(this._message);

  @override
  String toString() {
    return this._message;
  }
}

class ApiClientListResult<T> {
  String? next;
  String? previous;
  int? count;
  List<T> result = [];

  ApiClientListResult(
      {String? next, String? previous, int? count, required List<T> result}) {
    print("Printing Api Results ");
    print(result);
    this.result = result;
    this.next = next;
    this.previous = previous;
    this.count = count;
  }
}

class ApiClient {
  String token = "";
  bool isAuthenticated = false;
  final String baseUrl = 'http://192.168.6.56:8000';

  Map<String, String> headers = {'Content-Type': 'application/json'};

  Future<http.Response> get(String url,
      {Map<String, String>? headers, Map<String, dynamic>? parameters}) async {
    Map<String, String> newHeaders = this.headers;
    http.Response response;
    if (headers != null) {
      newHeaders = headers;
    }

    response = await http.get(
        Uri.parse(url).replace(queryParameters: parameters),
        headers: newHeaders);

    if (response.statusCode == 404) {
      throw NetworkFailure(
          "Ops, it seems you are not connected to the Internet");
    } else if (response.statusCode == 405) {
      throw NetworkFailure("Please Log in first.");
    }
    return response;
  }

  Future<http.Response> post(String url, Map<String, String> data,
      {Map<String, String>? headers}) async {
    Map<String, String> newHeaders = this.headers;
    if (headers != null) {
      newHeaders = headers;
    }
    final response = await http.post(
      Uri.parse(url),
      headers: newHeaders,
      body: jsonEncode(data),
    );
    if (response.statusCode == 404) {
      throw NetworkFailure("Sorry there is no internet connection");
    } else if (response.statusCode == 405) {
      throw NetworkFailure("Please Log in first.");
    }
    return response;
  }

  Future<List<Resturant>> fetchResturants() async {
    http.Response response;
    try {
      response = await get(baseUrl + '/api/v1/resturants/');
    } on SocketException catch (_) {
      throw NetworkFailure("No internet Connection");
    }

    List<Map> results =
        (jsonDecode(utf8.decode(response.bodyBytes))['results'] as List)
            .map((e) => e as Map<String, dynamic>)
            .toList();
    return Resturant.fromJson(results).toList();
  }

  Future<List<Food>> fetchResturantFoods({
    required int id,
  }) async {
    http.Response response;
    String apiUrl = baseUrl + '/api/v1/resturants/$id/foods/';
    try {
      response = await get(apiUrl);
    } on SocketException catch (_) {
      throw NetworkFailure("No internet Connection");
    }
    List responseData = jsonDecode(utf8.decode(response.bodyBytes)) as List;
    List<Map> results =
        responseData.map((e) => e as Map<String, dynamic>).toList();
    List<Food> foods = Food.fromJson(results);

    return foods;
  }

  Future<List<FoodMenu>> fetchResturantFoodMenu({
    required int id,
  }) async {
    http.Response response;
    String apiUrl = baseUrl + '/api/v1/resturants/$id/menu/';
    try {
      response = await get(apiUrl);
    } on SocketException catch (_) {
      throw NetworkFailure("No internet Connection");
    }
    List responseData = jsonDecode(utf8.decode(response.bodyBytes)) as List;
    List<Map> results =
        responseData.map((e) => e as Map<String, dynamic>).toList();
    List<FoodMenu> foods = FoodMenu.fromJson(results);

    return foods;
  }

  Future<List<Food>> fetchMenuFoods({
    required int id,
  }) async {
    http.Response response;
    String apiUrl = baseUrl + '/api/v1/food_menus/$id/foods/';
    try {
      response = await get(apiUrl);
    } on SocketException catch (_) {
      throw NetworkFailure("No internet Connection");
    }
    List responseData = jsonDecode(utf8.decode(response.bodyBytes)) as List;
    List<Map> results =
        responseData.map((e) => e as Map<String, dynamic>).toList();
    List<Food> foods = Food.fromJson(results);

    return foods;
  }

  Future<List<Groceries>> fetchGroceris() async {
    http.Response response;
    try {
      response = await get(baseUrl + '/api/v1/groceries/');
    } on SocketException catch (_) {
      throw NetworkFailure("No internet Connection");
    }

    List<Map> results =
        (jsonDecode(utf8.decode(response.bodyBytes))['results'] as List)
            .map((e) => e as Map<String, dynamic>)
            .toList();
    return Groceries.fromJson(results).toList();
  }
}

ApiClient apiClient = ApiClient();
