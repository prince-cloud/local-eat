import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:local_eat/components/progress_bar.dart';
import 'package:local_eat/components/search_box.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_eat/constants.dart';
import 'package:local_eat/models/resturant_model.dart';
import 'package:local_eat/pages/groceris/groceris_list.dart';
import 'package:local_eat/pages/groceris/grocery_shop_list.dart';
import 'package:local_eat/pages/resturants/resturant_card.dart';
import 'package:local_eat/pages/resturants/resturant_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf1f5ff),
      body: CustomScrollView(
        slivers: [
          // search
          SliverToBoxAdapter(
            child: Center(
              child: SearchBox(onChanged: ((value) => {})),
            ),
          ),

          // resturant and groceries card
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(8),
              child: GridView.count(
                crossAxisCount: 2,
                primary: false,
                shrinkWrap: true,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ResturantsList(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 7,
                        shadowColor: const Color.fromARGB(110, 0, 0, 0),
                        child: ClipRect(
                          child: BackdropFilter(
                            filter:
                                ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                            child: Container(
                              width: 130.0,
                              height: 160.0,
                              decoration: const BoxDecoration(
                                color: whiteColor,
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                    
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const ResturantsList(),
                                        ),
                                      );
                                    },
                                    icon: SvgPicture.asset(
                                      "assets/icons/pizza.svg",
                                    ),
                                  ),
                                  const Text(
                                    "Resturants",
                                    style: TextStyle(
                                      color: blackColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                     
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const ResturantsList(),
                                        ),
                                      );
                                    },
                                    icon: SvgPicture.asset(
                                      "assets/icons/right_arrow.svg",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                       Fluttertoast.showToast(msg: "Ops!, Sorry, Currently not Available Now");
                     /*  Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const GroceryShopList(),
                        ),
                      ); */
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 7,
                        shadowColor: const Color.fromARGB(110, 0, 0, 0),
                        child: ClipRect(
                          child: BackdropFilter(
                            filter:
                                ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                            child: Container(
                              width: 130.0,
                              height: 160.0,
                              decoration: const BoxDecoration(
                                color: whiteColor,
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                       Fluttertoast.showToast(msg: "Ops!, Sorry, Currently not Available Now");
                                      /* Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const GrocerisList(),
                                        ),
                                      ); */
                                    },
                                    icon: SvgPicture.asset(
                                      "assets/icons/vegetables.svg",
                                    ),
                                  ),
                                  const Text(
                                    "Groceries",
                                    style: TextStyle(
                                      color: blackColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                       Fluttertoast.showToast(msg: "Ops!, Sorry, Currently not Available Now");
                                      /* Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const GroceryShopList(),
                                        ),
                                      ); */
                                    },
                                    icon: SvgPicture.asset(
                                      "assets/icons/right_arrow.svg",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // popular restrurant title
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                "Popular Resturants",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          // returant list

          StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection("resturants").snapshots(),
            builder: (context, snapshot) {
              return !snapshot.hasData
                  ? SliverToBoxAdapter(
                      child: Center(child: circularProgress()),
                    )
                  : SliverStaggeredGrid.countBuilder(
                      crossAxisCount: 1,
                      staggeredTileBuilder: (context) =>
                          const StaggeredTile.fit(1),
                      itemBuilder: (context, index) {
                        Resturants resturant = Resturants.fromJson(
                            snapshot.data!.docs[index].data()!
                                as Map<String, dynamic>);
                        return resturantCard(
                          resturant: resturant,
                          context: context,
                        );
                      },
                      itemCount: snapshot.data!.docs.length,
                    );
            },
          ),

          // popular foods
          /* const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                "Popular Grocery Shop",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ), */
        ],
      ),
    );
  }
}


// #f1f5ff
