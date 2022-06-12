import 'package:flutter/material.dart';
import 'package:local_eat/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_eat/models/food_menu_models.dart';

class ResturantMenuFoods extends StatefulWidget {
  final Menus menu;
  const ResturantMenuFoods({Key? key, required this.menu}) : super(key: key);

  @override
  State<ResturantMenuFoods> createState() => _ResturantMenuFoodsState();
}

class _ResturantMenuFoodsState extends State<ResturantMenuFoods> {
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
                        image: NetworkImage("widget.menu.image"),
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
                          "widget.menu.name",
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
        ],
      ),
    );
  }
}
