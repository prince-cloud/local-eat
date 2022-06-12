import 'package:flutter/material.dart';
import 'package:local_eat/constants.dart';
import 'package:local_eat/models/food_model.dart';

class Cartitem extends StatelessWidget {
  final FoodItems? model;
  BuildContext? context;
  final int? quantityNumber;
  int? totalprice = 0;

  Cartitem({
    this.model,
    this.context,
    this.quantityNumber,
  });

  totalPrice() {
    //totalprice = quantityNumber! * int.parse(model!.price);
  }

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
            trailing: Text(
              "GHC " + model!.price.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
