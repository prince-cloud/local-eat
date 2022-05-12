import 'package:flutter/material.dart';
import 'package:local_eat/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_eat/models/food_menu_models.dart';
import 'package:local_eat/models/food_model.dart';
import 'package:local_eat/models/resturant_model.dart';
import 'package:local_eat/network_api.dart';
import 'package:local_eat/pages/resturants/resturant_foods.dart';
import 'package:local_eat/providers/resturant_detail_provider.dart';
import 'package:provider/provider.dart';

class ResturantDetail extends StatefulWidget {
  final Resturant resturant;
  const ResturantDetail({Key? key, required this.resturant}) : super(key: key);

  @override
  State<ResturantDetail> createState() => _ResturantDetailState();
}

class _ResturantDetailState extends State<ResturantDetail> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          ResturantDetailProvider(widget.resturant)..fetchData(),
      child: Scaffold(
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
            Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      height: 170,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(widget.resturant.image),
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
                            widget.resturant.name,
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
            FutureBuilder<List<FoodMenu>>(
              future: apiClient.fetchResturantFoodMenu(id: widget.resturant.id),
              builder: (BuildContext context,
                  AsyncSnapshot<List<FoodMenu>> foodMenu) {
                return Column(
                  children: [
                    if (foodMenu.hasError)
                      Center(
                        child: Text(foodMenu.error.toString()),
                      ),
                    Column(
                      children: [
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
                    if (foodMenu.data != null)
                      ...foodMenu.data!.map(
                        (menu) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ResturantMenuFoods(
                                    menu: menu,
                                  ),
                                ),
                              );
                            },
                            child: Card(
                              elevation: 7,
                              shadowColor: const Color.fromARGB(110, 0, 0, 0),
                              child: Column(
                                children: [
                                  Container(
                                    height: 150,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.black,
                                      image: DecorationImage(
                                        image: NetworkImage(menu.image),
                                        fit: BoxFit.cover,
                                        opacity: 0.3,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          menu.name,
                                          style: const TextStyle(
                                            color: Color(0xFFfcc833),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
