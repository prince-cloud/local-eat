class Food {
  int id;
  String  name, description, price;
  String? size;

  Food({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.size,
  });

  factory Food.fromMap(Map data) {
    return Food(
      id: data['id'] as int,
      name: data['name'].toString(),
      description: data['description'].toString(),
      price: data['price'] as String,
      size: data['size'] ?? "M",
    );
  }

  static List<Food> fromJson(List<Map> data) {
    List<Food> foods = [];

    for (Map i in data) {
      foods.add(Food.fromMap(i));
    }

    return foods;
  }
}
