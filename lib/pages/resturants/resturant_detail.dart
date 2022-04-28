import 'package:flutter/material.dart';
import 'package:local_eat/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_eat/models/resturant_model.dart';
import 'package:local_eat/providers/resturant_detail_provider.dart';
import 'package:local_eat/providers/resturants_provider.dart';
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
      child: Container(
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
                    style: TextStyle(
                        color: blackColor, fontWeight: FontWeight.bold),
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
                  // The containers in the background
                  Column(
                    children: <Widget>[
                      Container(
                        height: 200,
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
                      top: 150,
                      right: 20.0,
                      left: 20.0,
                    ),
                    child: SizedBox(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        color: Colors.white,
                        elevation: 7,
                        shadowColor: const Color.fromARGB(110, 0, 0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.resturant.name,
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
            ],
          ),
        ),
      ),
    );
  }
}
