import 'package:flutter/material.dart';
import 'package:local_eat/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_eat/models/food_menu_models.dart';
import 'package:local_eat/models/food_model.dart';
import 'package:local_eat/models/resturant_model.dart';
import 'package:local_eat/network_api.dart';
import 'package:local_eat/providers/menu_provider.dart';
import 'package:local_eat/providers/resturant_detail_provider.dart';
import 'package:provider/provider.dart';

class ResturantMenuFoods extends StatefulWidget {
  final FoodMenu menu;
  const ResturantMenuFoods({Key? key, required this.menu}) : super(key: key);

  @override
  State<ResturantMenuFoods> createState() => _ResturantMenuFoodsState();
}

class _ResturantMenuFoodsState extends State<ResturantMenuFoods> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MenuFoodProvider(widget.menu)..fetchData(),
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
                      height: 140,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(widget.menu.image),
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
                    top: 80,
                    right: 20.0,
                    left: 20.0,
                  ),
                  child: SizedBox(
                    height: 50,
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
                            widget.menu.name,
                            style: const TextStyle(
                              fontSize: 27,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
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
            FutureBuilder<List<Food>>(
              future: apiClient.fetchMenuFoods(id: widget.menu.id),
              builder: (BuildContext context, AsyncSnapshot<List<Food>> foods) {
                return Column(
                  children: [
                    if (foods.hasError)
                      Center(
                        child: Text(foods.error.toString()),
                      ),
                    if (foods.data != null)
                      ...foods.data!.map(
                        (food) {
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
                                    onTap: () {
                                      print(food.name + " added to list");
                                    },
                                    title: Text(food.name),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(food.description),
                                        const SizedBox(
                                          height: 8.0,
                                        ),
                                      ],
                                    ),
                                    trailing: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Icon(
                                          Icons.add_circle,
                                          color:
                                              Color.fromARGB(190, 255, 153, 0),
                                        )
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
                                      if (food.size != null ||
                                          food.size != "" ||
                                          food.size!.isNotEmpty)
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15),
                                          child: Text(
                                            "Size: " + food.size!,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 16),
                                        child: Text('GHC ' + food.price),
                                      ),
                                    ],
                                  )
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
