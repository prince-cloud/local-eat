import 'package:flutter/material.dart';
import 'package:local_eat/components/progress_bar.dart';
import 'package:local_eat/functions/cart_item_counter.dart';
import 'package:local_eat/functions/functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:local_eat/functions/total_order_amount.dart';
import 'package:local_eat/models/food_model.dart';
import 'package:local_eat/pages/address/address_page.dart';
import 'package:local_eat/pages/cart/cart_item.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  final String? resturantUid;
  const CartPage({Key? key, this.resturantUid}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<int>? separateitemQuantityList;

  num totalAmount = 0;

  @override
  void initState() {
    super.initState();
/*     totalAmount = 0;
    Provider.of<TotalOrderAmount>(context, listen: false).displayTotalAmount(0);
     */
    separateitemQuantityList = separateItemQuantity();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf1f5ff),
      appBar: AppBar(
        backgroundColor: const Color(0xFFfcc833),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
          color: Colors.black,
        ),
        title: const Text("My Order", style: TextStyle(color: Colors.black)),
      ),
      body: CustomScrollView(
        slivers: [
          // total cart ammount
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 10,
            ),
          ),

          //items in cart
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("food_items")
                .where("itemId", whereIn: separateItemIds())
                .orderBy("dateCreated", descending: true)
                .snapshots(),
            builder: (context, snapShot) {
              return !snapShot.hasData
                  ? SliverToBoxAdapter(
                      child: Center(
                        child: circularProgress(),
                      ),
                    )
                  : snapShot.data!.docs.isEmpty
                      ? SliverToBoxAdapter(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              SizedBox(
                                height: 30,
                              ),
                              Icon(Icons.emoji_people),
                              Text(
                                "Your Have no Orders",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        )
                      : SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              FoodItems model = FoodItems.fromJson(
                                snapShot.data!.docs[index].data()!
                                    as Map<String, dynamic>,
                              );

                              if (index == 0) {
                                totalAmount = 0;
                                totalAmount += (model.price! *
                                    separateitemQuantityList![index]);
                              } else {
                                totalAmount += (model.price! *
                                    separateitemQuantityList![index]);
                              }

                              if (snapShot.data!.docs.length - 1 == index) {
                                WidgetsBinding.instance
                                    .addPostFrameCallback((timeStamp) {
                                  Provider.of<TotalOrderAmount>(context,
                                          listen: false)
                                      .displayTotalAmount(
                                          totalAmount.toDouble());
                                });
                              }

                              return Cartitem(
                                model: model,
                                context: context,
                                quantityNumber:
                                    separateitemQuantityList![index],
                              );
                            },
                            childCount: snapShot.hasData
                                ? snapShot.data!.docs.length
                                : 0,
                          ),
                        );
            },
          ),

          SliverToBoxAdapter(
            child: Consumer2<TotalOrderAmount, CartItemCounter>(
              builder: (context, amountProvider, cartProvider, c) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: cartProvider.count == 0
                        ? Container()
                        : Text(
                            "Total: GHC ${amountProvider.tAmount.toString()}"),
                  ),
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton:
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Align(
          alignment: Alignment.bottomLeft,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.black,
              padding: const EdgeInsets.symmetric(
                horizontal: 50,
                vertical: 10,
              ),
            ),
            onPressed: () {
              clearCart(context);
            },
            child: const Text(
              "Clear",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.orange,
              padding: const EdgeInsets.symmetric(
                horizontal: 50,
                vertical: 10,
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AdressPage(
                    totAlamount: totalAmount.toDouble(),
                    resturantUid: widget.resturantUid!,
                  ),
                ),
              );
            },
            child: const Text(
              "Next",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
