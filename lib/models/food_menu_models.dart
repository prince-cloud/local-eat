import 'package:cloud_firestore/cloud_firestore.dart';

class Menus {
  String? menuId, resturantUid, menuTitle, menuInfo, thumbnailUrl, status;

  Timestamp? dateCreated;

  Menus({
    this.menuId,
    this.resturantUid,
    this.menuTitle,
    this.menuInfo,
    this.dateCreated,
    this.thumbnailUrl,
    this.status,
  });

  Menus.fromJson(Map<String, dynamic> json) {
    menuId = json['menuId'];
    resturantUid = json['resturantUID'];
    menuTitle = json['menuTitle'];
    menuInfo = json['menuInfo'];
    dateCreated = json['dateCreated'];
    thumbnailUrl = json['thumbnailUrl'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['menuId'] = menuId;
    data['resturantUID'] = resturantUid;
    data['menuTitle'] = menuTitle;
    data['menuInfo'] = menuInfo;
    data['dateCreated'] = dateCreated;
    data['thumbnailUrl'] = thumbnailUrl;
    data['status'] = status;

    return data;
  }
}
