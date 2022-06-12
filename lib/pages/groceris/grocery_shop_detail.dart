import 'package:flutter/material.dart';
import 'package:local_eat/components/search_box.dart';
import 'package:local_eat/models/grocery_shop_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_eat/constants.dart';

class GroceryShopDetail extends StatefulWidget {
  final GroceryShop groceryShop;
  const GroceryShopDetail({Key? key, required this.groceryShop})
      : super(key: key);

  @override
  State<GroceryShopDetail> createState() => _GroceryShopDetailState();
}

class _GroceryShopDetailState extends State<GroceryShopDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                text: "Groceries",
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
        ],
      ),
    );
  }
}
