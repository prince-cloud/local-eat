import 'package:flutter/material.dart';
import 'package:local_eat/models/resturant_model.dart';
import 'package:local_eat/pages/resturants/resturant_detail.dart';

Widget resturantCard(
    {required Resturants resturant, required BuildContext context}) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ResturantDetail(
            resturant: resturant,
          ),
        ),
      );
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
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
                  image: NetworkImage(resturant.resturantAvatarUrl.toString()),
                  fit: BoxFit.cover,
                  opacity: 0.3,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    resturant.resturantName.toString(),
                    style: const TextStyle(
                      color: Color(0xFFfcc833),
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  /* Wrap(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.all(5),
                        child: const Text(
                          " tag",
                          style: TextStyle(
                            color: Color.fromARGB(178, 255, 255, 255),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )
                    ],
                  ) */
                ],
              ),
            ),
            /* Container(
              color: Colors.white,
              height: 30,
              child: Row(),
            ), */
            /*  const SizedBox(
              height: 20,
            ), */
          ],
        ),
      ),
    ),
  );
}
