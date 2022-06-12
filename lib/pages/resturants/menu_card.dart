import 'package:flutter/material.dart';
import 'package:local_eat/models/food_menu_models.dart';
import 'package:local_eat/pages/resturants/menu_items.dart';

Widget resturantMenuCard(
    {required Menus model, required BuildContext context}) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => MenuItems(
            model: model,
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
                image: NetworkImage(
                  model.thumbnailUrl.toString(),
                ),
                fit: BoxFit.cover,
                opacity: 0.6,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  model.menuTitle.toString(),
                  style: const TextStyle(
                    color: Color(0xFFfcc833),
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    ),
  );
}
