import 'package:flutter/material.dart';
import 'package:local_eat/models/food_model.dart';

// ignore: must_be_immutable
class Cartitem extends StatelessWidget {
  final FoodItems? model;
  BuildContext? context;
  final int? quantityNumber;
  final String? itemId;

  Cartitem({
    Key? key,
    this.model,
    this.context,
    this.quantityNumber,
    this.itemId,
  }) : super(key: key);

  /* deleteOrderItem() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(sharedPreferences!.getString("uid"))
        .collection("userCart")
        .getData()
        .doc("productIds")
        .where("itemId", whereIn: separateItemIds())
        .delete()
        .then((value) {
      Fluttertoast.showToast(msg: "Address succesfful deleted");
    });
  } */

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Card(
        elevation: 7,
        shadowColor: const Color.fromARGB(110, 0, 0, 0),
        child: InkWell(
          child: ListTile(
            title: Text(
              model!.itemTitle.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              "x " + quantityNumber.toString(),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "GHC " + (model!.price! * quantityNumber!).toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
                /* IconButton(
                  onPressed: () {
                    deleteOrderItem();
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 14,
                  ),
                ), */
              ],
            ),
          ),
        ),
      ),
    );
  }
}
