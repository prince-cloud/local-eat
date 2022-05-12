class GroceryShop {
  int id;
  String name, phone, email, location, image;

  GroceryShop(
      {required this.id,
      required this.name,
      required this.email,
      required this.phone,
      required this.location,
      required this.image});

  factory GroceryShop.fromMap(Map data) {
    return GroceryShop(
      id: data['id'] as int,
      name: data['name'] as String,
      email: data['email'] as String,
      phone: data['phone'] as String,
      location: data['location'] as String,
      image: data['image'] as String,
    );
  }

  static List<GroceryShop> fromJson(List<Map> data) {
    List<GroceryShop> groceryShops = [];
    for (Map i in data) {
      groceryShops.add(
        GroceryShop.fromMap(i),
      );
    }

    return groceryShops;
  }
}
