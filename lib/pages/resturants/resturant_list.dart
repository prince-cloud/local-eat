import 'package:flutter/material.dart';
import 'package:local_eat/components/search_box.dart';
import 'package:local_eat/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_eat/pages/resturants/resturant_card.dart';
import 'package:local_eat/providers/resturants_list_provider.dart';
import 'package:provider/provider.dart';

class ResturantsList extends StatefulWidget {
  const ResturantsList({Key? key}) : super(key: key);

  @override
  State<ResturantsList> createState() => _ResturantsListState();
}

class _ResturantsListState extends State<ResturantsList> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => ResturantsProvider()..fetchData(),
      builder: (BuildContext context, _) {
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
          body: Consumer<ResturantsProvider>(
            builder: (context, resturantsProvider, _) {
              return RefreshIndicator(
                onRefresh: () async {
                  resturantsProvider.fetchData();
                },
                child: ListView(
                  children: [
                    Center(
                      child: SearchBox(
                        onChanged: (value) {},
                      ),
                    ),
                    ...(resturantsProvider.resturants).map(
                      (resturant) {
                        return resturantCard(
                          resturant: resturant,
                          context: context,
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
