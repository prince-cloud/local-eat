import 'package:flutter/material.dart';
import 'package:local_eat/components/cart_button.dart';
import 'package:local_eat/components/progress_bar.dart';
import 'package:local_eat/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_eat/functions/functions.dart';
import 'package:local_eat/models/food_menu_models.dart';
import 'package:local_eat/models/resturant_model.dart';
import 'package:local_eat/pages/resturants/menu_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:local_eat/splashScreen/main_page.dart';
import 'package:local_eat/splashScreen/splash_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ResturantDetail extends StatefulWidget {
  final Resturants resturant;
  const ResturantDetail({Key? key, required this.resturant}) : super(key: key);

  @override
  State<ResturantDetail> createState() => _ResturantDetailState();
}

class _ResturantDetailState extends State<ResturantDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: customCartButtom(context),
      backgroundColor: const Color(0xFFf1f5ff),
      appBar: AppBar(
        backgroundColor: const Color(0xFFfcc833),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            clearCart(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MainPage(),
              ),
            );
            Fluttertoast.showToast(msg: "Orders cleared");
          },
          color: Colors.white,
        ),
        title: RichText(
          text: const TextSpan(
            children: [
              TextSpan(
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
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          content: Text('Tap again to go back, cart will be cleared.'),
        ),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        height: 170,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                                widget.resturant.resturantAvatarUrl.toString()),
                            fit: BoxFit.cover,
                            opacity: 0.4,
                          ),
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    padding: const EdgeInsets.only(
                      top: 120,
                      right: 20.0,
                      left: 20.0,
                    ),
                    child: SizedBox(
                      height: 120,
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        color: Colors.white,
                        elevation: 7,
                        shadowColor: const Color.fromARGB(110, 0, 0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              widget.resturant.resturantName.toString(),
                              style: const TextStyle(
                                fontSize: 27,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: const [
                                    Icon(
                                      Icons.timelapse,
                                      color: Colors.black54,
                                    ),
                                    Text("30-40")
                                  ],
                                ),
                                Column(),
                                Column(
                                  children: const [
                                    Icon(
                                      Icons.motorcycle,
                                      color: Colors.black54,
                                    ),
                                    Text("Ghc 5")
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Our Menu",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 20, left: 20, top: 3, bottom: 3),
                        child: Container(
                          color: const Color.fromARGB(66, 10, 0, 0),
                          height: 1.0,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ],
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("resturants")
                  .doc(
                    widget.resturant.resturantUID,
                  )
                  .collection("menus")
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
                          Menus model = Menus.fromJson(
                            snapshot.data!.docs[index].data()!
                                as Map<String, dynamic>,
                          );
                          return resturantMenuCard(
                            context: context,
                            model: model,
                          );
                        },
                        itemCount: snapshot.data!.docs.length,
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}

/* 
 ListView(
        children: [
          Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    height: 170,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            widget.resturant.resturantAvatarUrl.toString()),
                        fit: BoxFit.cover,
                        opacity: 0.4,
                      ),
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.only(
                  top: 120,
                  right: 20.0,
                  left: 20.0,
                ),
                child: SizedBox(
                  height: 120,
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    color: Colors.white,
                    elevation: 7,
                    shadowColor: const Color.fromARGB(110, 0, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          widget.resturant.resturantName.toString(),
                          style: const TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: const [
                                Icon(
                                  Icons.timelapse,
                                  color: Colors.black54,
                                ),
                                Text("30-40")
                              ],
                            ),
                            Column(),
                            Column(
                              children: const [
                                Icon(
                                  Icons.motorcycle,
                                  color: Colors.black54,
                                ),
                                Text("Ghc 5")
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          
          
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("resturants")
                .doc(
                  sharedPreferences!.getString("uid"),
                )
                .collection("menus")
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
                        Menus model = Menus.fromJson(
                          snapshot.data!.docs[index].data()!
                              as Map<String, dynamic>,
                        );
                        return resturantMenuCard(
                          context: context,
                          /*model: model, */
                        );
                      },
                      itemCount: snapshot.data!.docs.length,
                    );
            },
          ),
        ],
      ),
    
 */
