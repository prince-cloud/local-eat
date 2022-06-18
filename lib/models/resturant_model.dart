class Resturants {
  String? resturantUID,
      resturantName,
      resturantAvatarUrl,
      resturantEmail,
      resturantLocation;
  double? locLat, locLong;

  Resturants.fromJson(Map<String, dynamic> json) {
    resturantUID = json["resturantUID"];
    resturantName = json["resturantName"];
    resturantAvatarUrl = json["resturantImageUrl"];
    resturantEmail = json["resturantEmail"];
    resturantLocation = json["location"];
    locLat = json["lat"];
    locLong = json["lng"];
  }

  get resturantImageUrl => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["resturantUID"] = resturantUID;
    data["resturantName"] = resturantName;
    data["resturantImageUrl"] = resturantAvatarUrl;
    data["resturantEmail"] = resturantEmail;
    data["resturantLocation"] = resturantLocation;
    data["lat"] = locLat;
    data["lng"] = locLong;

    return data;
  }
}
