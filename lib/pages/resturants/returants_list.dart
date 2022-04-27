
import 'package:flutter/material.dart';
import 'package:local_eat/components/search_box.dart';
import 'package:local_eat/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ResturantsList extends StatelessWidget {
  const ResturantsList({Key? key}) : super(key: key);

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
                text: "Resturants",
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
          Card(
            elevation: 7,
            shadowColor: const Color.fromARGB(110, 0, 0, 0),
            child: Column(
              children: [
                Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.black.withOpacity(0.8),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/resturant.jpg'),
                      fit: BoxFit.cover,
                      opacity: 0.5,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Pizza Man Resturant",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      Wrap(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.all(5),
                            margin: const EdgeInsets.all(5),
                            child: const Text(
                              "Chicken",
                              style: TextStyle(
                                color: Color.fromARGB(178, 255, 255, 255),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.all(5),
                            margin: const EdgeInsets.all(5),
                            child: const Text(
                              "Pizza",
                              style: TextStyle(
                                color: Color.fromARGB(178, 255, 255, 255),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.all(5),
                            margin: const EdgeInsets.all(5),
                            child: const Text(
                              "Food",
                              style: TextStyle(
                                color: Color.fromARGB(178, 255, 255, 255),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  height: 30,
                  child: Row(),
                )
              ],
            ),
          ),
          Card(
            elevation: 7,
            shadowColor: const Color.fromARGB(110, 0, 0, 0),
            child: Column(
              children: [
                Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.black.withOpacity(0.8),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/resturant2.jpg'),
                      fit: BoxFit.cover,
                      opacity: 0.5,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Rosty Foods",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      Wrap(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.all(5),
                            margin: const EdgeInsets.all(5),
                            child: const Text(
                              "Pizza",
                              style: TextStyle(
                                color: Color.fromARGB(178, 255, 255, 255),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.all(5),
                            margin: const EdgeInsets.all(5),
                            child: const Text(
                              "Chicken",
                              style: TextStyle(
                                color: Color.fromARGB(178, 255, 255, 255),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.all(5),
                            margin: const EdgeInsets.all(5),
                            child: const Text(
                              "Assorted Rice",
                              style: TextStyle(
                                color: Color.fromARGB(178, 255, 255, 255),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.all(5),
                            margin: const EdgeInsets.all(5),
                            child: const Text(
                              "Healthy",
                              style: TextStyle(
                                color: Color.fromARGB(178, 255, 255, 255),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  height: 30,
                  child: Row(),
                )
              ],
            ),
          ),
          Card(
            elevation: 7,
            shadowColor: const Color.fromARGB(110, 0, 0, 0),
            child: Column(
              children: [
                Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.black.withOpacity(0.8),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/resturant1.jpg'),
                      fit: BoxFit.cover,
                      opacity: 0.5,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Waakye Embazy",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      Wrap(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.all(5),
                            margin: const EdgeInsets.all(5),
                            child: const Text(
                              "Jollof",
                              style: TextStyle(
                                color: Color.fromARGB(178, 255, 255, 255),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.all(5),
                            margin: const EdgeInsets.all(5),
                            child: const Text(
                              "Local Food",
                              style: TextStyle(
                                color: Color.fromARGB(178, 255, 255, 255),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  height: 30,
                  child: Row(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
