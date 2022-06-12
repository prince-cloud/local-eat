class Resturants {
  String? resturantUID, resturantName, resturantAvatarUrl, resturantEmail;

  Resturants.fromJson(Map<String, dynamic> json) {
    resturantUID = json["resturantUID"];
    resturantName = json["resturantName"];
    resturantAvatarUrl = json["resturantAvatarUrl"];
    resturantEmail = json["resturantEmail"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["resturantUID"] = this.resturantUID;
    data["resturantName"] = this.resturantName;
    data["resturantAvatarUrl"] = this.resturantAvatarUrl;
    data["resturantEmail"] = this.resturantEmail;

    return data;
  }
}
