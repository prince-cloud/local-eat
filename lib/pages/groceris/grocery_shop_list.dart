import 'package:flutter/material.dart';
import 'package:local_eat/components/search_box.dart';
import 'package:local_eat/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GroceryShopList extends StatefulWidget {
  const GroceryShopList({Key? key}) : super(key: key);

  @override
  State<GroceryShopList> createState() => _GroceryShopListState();
}

class _GroceryShopListState extends State<GroceryShopList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf1f5ff),
      appBar: AppBar(
        backgroundColor: const Color(0xFFfcc833),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
          color: Colors.white,
        ),
        title: RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: "Grocery Shops",
                style:
                    TextStyle(color: blackColor, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: SvgPicture.asset("assets/icons/notification.svg"),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        children: [
          Center(
            child: SearchBox(
              onChanged: (value) {},
            ),
          ),
          /* ...(groceryShopProvider.groceryShop).map(
                (groceryShop) {
                  return groceryShopCard(
                    groceryShop: groceryShop,
                    context: context,
                  );
                },
              ), */
        ],
      ),
    );
  }
}
