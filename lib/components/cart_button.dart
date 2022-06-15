import 'package:flutter/material.dart';
import 'package:local_eat/functions/cart_item_counter.dart';
import 'package:local_eat/pages/cart/cart.dart';
import 'package:provider/provider.dart';

Widget customCartButtom(
  BuildContext context,
  String? resturantUid,
) {
  return FloatingActionButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CartPage(resturantUid: resturantUid),
        ),
      );
    },
    tooltip: 'Increment',
    child: Stack(
      children: [
        const Icon(
          Icons.shopify,
        ),
        Positioned(
          top: -3,
          left: -1,
          child: Consumer<CartItemCounter>(
            builder: (context, counter, c) {
              return Text(
                counter.count.toString(),
              );
            },
          ),
        ),
      ],
    ),
  );
}
