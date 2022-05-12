import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

class Groceries {
  int id;
  String name, price, description, image;

  Groceries({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.image,
  });

  factory Groceries.fromMap(Map data) {
    return Groceries(
      id: data['id'] as int,
      name: data['name'],
      price: data['price'],
      description: data['description'],
      image: data['image'],
    );
  }

  static List<Groceries> fromJson(List<Map> data) {
    List<Groceries> groceries = [];
    for (Map i in data) {
      groceries.add(
        Groceries.fromMap(i),
      );
    }
    ;

    return groceries;
  }
}
