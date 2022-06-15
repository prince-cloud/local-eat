import 'package:cloud_firestore/cloud_firestore.dart';

class FoodItems {
  String? itemId,
      resturantId,
      resturantName,
      menuId,
      itemTitle,
      shortDescription,
      thumbnail,
      status;
  int? price;
  Timestamp? dateCreated;

  FoodItems({
    this.itemId,
    this.resturantId,
    this.resturantName,
    this.menuId,
    this.itemTitle,
    this.shortDescription,
    this.thumbnail,
    this.status,
    this.price,
    this.dateCreated,
  });

  FoodItems.fromJson(Map<String, dynamic> json) {
    itemId = json['itemId'];
    resturantId = json['resturantId'];
    resturantName = json['resturantName'];
    menuId = json['menuId'];
    itemTitle = json['itemTitle'];
    shortDescription = json['shortDescription'];
    thumbnail = json['thumbnailUrl'];
    status = json['status'];
    price = json['price'];
    dateCreated = json['dateCreated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['itemId'] = itemId;
    data['resturantId'] = resturantId;
    data['resturantName'] = resturantName;
    data['menuId'] = menuId;
    data['itemTitle'] = itemTitle;
    data['shortDescription'] = shortDescription;
    data['thumbnailUrl'] = thumbnail;
    data['status'] = status;
    data['price'] = price;
    data['dateCreated'] = dateCreated;

    return data;
  }
}
