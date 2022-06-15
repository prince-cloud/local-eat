class Resturants {
  String? resturantUID, resturantName, resturantAvatarUrl, resturantEmail;

  Resturants.fromJson(Map<String, dynamic> json) {
    resturantUID = json["resturantUID"];
    resturantName = json["resturantName"];
    resturantAvatarUrl = json["resturantAvatarUrl"];
    resturantEmail = json["resturantEmail"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["resturantUID"] = resturantUID;
    data["resturantName"] = resturantName;
    data["resturantAvatarUrl"] = resturantAvatarUrl;
    data["resturantEmail"] = resturantEmail;

    return data;
  }
}
