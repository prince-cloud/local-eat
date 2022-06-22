import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:local_eat/components/cart_button.dart';
import 'package:local_eat/components/progress_bar.dart';
import 'package:local_eat/functions/functions.dart';
import 'package:local_eat/global.dart';
import 'package:local_eat/models/food_menu_models.dart';
import 'package:local_eat/models/food_model.dart';
import 'package:local_eat/pages/auth/auth_screen.dart';
import 'package:local_eat/pages/auth/login.dart';
import 'package:number_inc_dec/number_inc_dec.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MenuItems extends StatefulWidget {
  final Menus model;

  const MenuItems({Key? key, required this.model}) : super(key: key);

  @override
  State<MenuItems> createState() => _MenuItemsState();
}

class _MenuItemsState extends State<MenuItems> {
  TextEditingController quantityController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      
            floatingActionButton: firebaseAuth.currentUser != null ?
          customCartButtom(context, widget.model.resturantUid!) : Container(),
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
        title: Text(widget.model.menuTitle.toString(),
            style: const TextStyle(color: Colors.black)),
      ),
      body: CustomScrollView(
        slivers: [
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("resturants")
                .doc(widget.model.resturantUid)
                .collection("menus")
                .doc(widget.model.menuId)
                .collection('food_items')
                .orderBy("dateCreated", descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              return !snapshot.hasData
                  ? SliverToBoxAdapter(
                      child: Center(
                        child: circularProgress(),
                      ),
                    )
                  : SliverStaggeredGrid.countBuilder(
                      crossAxisCount: 1,
                      staggeredTileBuilder: (context) =>
                          const StaggeredTile.fit(1),
                      itemBuilder: (context, index) {
                        FoodItems model = FoodItems.fromJson(
                          snapshot.data!.docs[index].data()!
                              as Map<String, dynamic>,
                        );
                        return Card(
                          elevation: 7,
                          shadowColor: const Color.fromARGB(148, 0, 0, 0),
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ListTile(
                                  title: Text(model.itemTitle.toString()),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(model.shortDescription.toString()),
                                      const SizedBox(
                                        height: 8.0,
                                      ),
                                    ],
                                  ),
                                  trailing: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          if (firebaseAuth.currentUser ==
                                              null) {
                                            Fluttertoast.showToast(
                                                msg:
                                                    "Log In or Sign Up to place an order");
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const AuthScreen(),
                                              ),
                                            );
                                          } else {
                                            showDialog(
                                              context:
                                                  _scaffoldKey.currentContext!,
                                              //context: context,
                                              builder: (currentContext) {
                                                return AlertDialog(
                                                  title: Text(
                                                    "Order - " +
                                                        model.itemTitle
                                                            .toString(),
                                                    style: const TextStyle(
                                                        fontSize: 14),
                                                  ),
                                                  content:
                                                      NumberInputWithIncrementDecrement(
                                                    controller:
                                                        quantityController,
                                                    min: 1,
                                                    initialValue: 1,
                                                  ),
                                                  actions: [
                                                    Center(
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          int itemQuantity =
                                                              int.parse(
                                                                  quantityController
                                                                      .text);
                                                          // check if item already exits
                                                          List<String>
                                                              separateItemIdsList =
                                                              separateItemIds();

                                                          separateItemIdsList
                                                                  .contains(model
                                                                      .itemId)
                                                              ? Fluttertoast
                                                                  .showToast(
                                                                  msg:
                                                                      "Item already added.",
                                                                )
                                                              :
                                                              // add to cart function
                                                              addItemToCart(
                                                                  model.itemId,
                                                                  itemQuantity,
                                                                  context,
                                                                );
                                                          Navigator.of(
                                                                  currentContext)
                                                              .pop();
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          primary: const Color
                                                                  .fromARGB(
                                                              255, 0, 0, 0),
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                            horizontal: 100,
                                                            //vertical: 10,
                                                          ),
                                                        ),
                                                        child: const Text(
                                                          "Order",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          }
                                        },
                                        icon: const Icon(
                                          Icons.add_circle,
                                          color:
                                              Color.fromARGB(190, 255, 153, 0),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 20, left: 20, top: 3, bottom: 3),
                                  child: Container(
                                    color: const Color(0xFFEBEBEB),
                                    height: 1.0,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: const [],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 16),
                                      child: Text(
                                        'GHC ${model.price}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: snapshot.data!.docs.length,
                    );
            },
          ),
        ],
      ),
    );
  }
}
