import 'package:flutter/material.dart';
import 'package:local_eat/functions/cart_item_counter.dart';
import 'package:local_eat/global.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_eat/splashScreen/main_page.dart';
import 'package:provider/provider.dart';

separateItemIds() {
  List<String> separateItemIdsList = [], defaultItemList = [];
  int i = 0;

  defaultItemList = sharedPreferences!.getStringList("userCart")!;

  for (i; i < defaultItemList.length; i++) {
    String item = defaultItemList[i].toString();
    var position = item.lastIndexOf(":");
    String getItemId = (position != -1) ? item.substring(0, position) : item;

    separateItemIdsList.add(getItemId);
  }

  return separateItemIdsList;
}

addItemToCart(String? itemId, int itemQuantity, BuildContext context) {
  List<String>? tempList = sharedPreferences!.getStringList('userCart');
  tempList!.add(itemId! + ":$itemQuantity");

  FirebaseFirestore.instance
      .collection("users")
      .doc(firebaseAuth.currentUser!.uid)
      .update({
    "userCart": tempList,
  }).then((value) {
    // add flutter toas message
    Fluttertoast.showToast(msg: "Item succesffuly added.");

    sharedPreferences!.setStringList("userCart", tempList);

    //update quantity counter
    Provider.of<CartItemCounter>(context, listen: false)
        .displayCartItemCounter();
  });
}

separateItemQuantity() {
  List<int> separeteitemQuantityList = [];
  List<String> defaultItemList = [];
  int i = 1;

  defaultItemList = sharedPreferences!.getStringList("userCart")!;

  for (i; i < defaultItemList.length; i++) {
    String item = defaultItemList[i].toString();
    List<String> listItemCharacters = item.split(":").toList();
    var quantityNumber = int.parse(listItemCharacters[1].toString());
    separeteitemQuantityList.add(quantityNumber);
  }

  return separeteitemQuantityList;
}

clearCart(context) {
  sharedPreferences!.setStringList("userCart", ["garbageValue"]);
  List<String>? emptyList = sharedPreferences!.getStringList("userCart");

  FirebaseFirestore.instance
      .collection("users")
      .doc(firebaseAuth.currentUser!.uid)
      .update({"userCart": emptyList}).then((value) {
    sharedPreferences!.setStringList("userCart", emptyList!);
    Provider.of<CartItemCounter>(context, listen: false)
        .displayCartItemCounter();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MainPage(),
      ),
    );
    /* Fluttertoast.showToast(msg: "Orders cleared"); */
  });
}
