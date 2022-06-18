import 'package:flutter/material.dart';
import 'package:local_eat/components/progress_bar.dart';
import 'package:local_eat/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:local_eat/models/resturant_model.dart';
import 'package:local_eat/pages/resturants/resturant_card.dart';

class ResturantsList extends StatefulWidget {
  const ResturantsList({Key? key}) : super(key: key);

  @override
  State<ResturantsList> createState() => _ResturantsListState();
}

class _ResturantsListState extends State<ResturantsList> {
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
          /* actions: <Widget>[
            IconButton(
              icon: SvgPicture.asset("assets/icons/notification.svg"),
              onPressed: () {},
            ),
          ], */
        ),
        body: CustomScrollView(
          slivers: [
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("resturants")
                  .snapshots(),
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
          ],
        ));
  }
}
