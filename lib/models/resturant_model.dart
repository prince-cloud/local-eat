class Resturant {
  int id;
  String name, image;
  List<String> tags;
  List<String> foodMenu;

  Resturant({
    required this.id,
    required this.name,
    required this.image,
    required this.tags,
    required this.foodMenu,
  });

  factory Resturant.fromMap(Map data) {
    return Resturant(
      id: data['id'] as int,
      name: data['name'].toString(),
      image: data['image'].toString(),
      tags: (data['tags'] as List)
          .map((tag) => (tag as Map)['tag'] as String)
          .toList(),
      foodMenu: (data['food_menu'] as List)
          .map((food) => (food as Map)['name'] as String)
          .toList(),
    );
  }

  static List<Resturant> fromJson(List<Map> data) {
    List<Resturant> resturants = [];

    for (Map i in data) {
      resturants.add(Resturant.fromMap(i));
    }
    return resturants;
  }
}
