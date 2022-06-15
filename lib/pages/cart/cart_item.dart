import 'package:flutter/material.dart';
import 'package:local_eat/global.dart';
import 'package:local_eat/models/food_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore: must_be_immutable
class Cartitem extends StatelessWidget {
  final FoodItems? model;
  BuildContext? context;
  final int? quantityNumber;
  //int? totalprice = 0;

  Cartitem({
    Key? key,
    this.model,
    this.context,
    this.quantityNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Card(
        elevation: 7,
        shadowColor: const Color.fromARGB(110, 0, 0, 0),
        child: InkWell(
          child: ListTile(
            /* leading: Image(
              width: 80,
              height: 200,
              fit: BoxFit.cover,
              image: NetworkImage(
                model!.thumbnail.toString(),
              ),
            ), */

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
              children: [
                Text(
                  "GHC " + (model!.price! * quantityNumber!).toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    FirebaseFirestore.instance
                        .collection("users")
                        .doc(sharedPreferences!.getString("uid"))
                        .collection("userCart")
                        .doc(model!.itemId)
                        .delete()
                        .whenComplete(
                      () {
                        Fluttertoast.showToast(
                          msg: "Item succesffully deleted",
                        );
                      },
                    );

                    /* Fluttertoast.showToast(msg: "Orders cleared"); */
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
