import 'package:flutter/material.dart';
import 'package:local_eat/functions/cart_item_counter.dart';
import 'package:local_eat/pages/resturants/cart.dart';
import 'package:provider/provider.dart';

Widget customCartButtom(BuildContext context) {
  return FloatingActionButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CartPage(),
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

/* 
FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CartPage(),
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
      ),

 */