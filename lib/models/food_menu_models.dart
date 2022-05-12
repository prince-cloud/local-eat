import 'package:local_eat/models/resturant_model.dart';

class FoodMenu {
  int id;
  String name, image;

  FoodMenu({
    required this.id,
    required this.name,
    required this.image,
  });

  factory FoodMenu.fromMap(Map data) {
    return FoodMenu(
      id: data['id'] as int,
      name: data['name'].toString(),
      image: data['image'].toString(),
    );
  }

  static List<FoodMenu> fromJson(List<Map> data) {
    List<FoodMenu> foodMenu = [];

    for (Map i in data) {
      foodMenu.add(FoodMenu.fromMap(i));
    }

    return foodMenu;
  }
}
