class Resturant {
  int id;
  String name, image;
  List<String> tags;
  List<String> foods;

  Resturant({
    required this.id,
    required this.name,
    required this.image,
    required this.tags,
    required this.foods,
  });

  factory Resturant.fromMap(Map data) {
    return Resturant(
      id: data['id'] as int,
      name: data['name'].toString(),
      image: data['image'].toString(),
      tags: (data['tags'] as List)
          .map((tag) => (tag as Map)['tag'] as String)
          .toList(),
      foods: (data['foods'] as List)
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
