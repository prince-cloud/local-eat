import 'package:flutter/material.dart';
import 'package:local_eat/components/progress_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:local_eat/constants.dart';
import 'package:local_eat/functions/functions.dart';
import 'package:local_eat/global.dart';
import 'package:local_eat/pages/orders/order_card.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({Key? key}) : super(key: key);

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFf1f5ff),
        body: ListView(
          children: [
            Container(
              color: primaryColor,
              padding: const EdgeInsets.all(10),
              child: const Center(
                child: Text(
                  "History",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            Container(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .doc(sharedPreferences!.getString("uid"))
                    .collection("orders")
                    .where("status", isEqualTo: "ended")
                    .orderBy("orderTime", descending: true)
                    .snapshots(),
                builder: (context, snapshots) {
                  return snapshots.hasData
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshots.data!.docs.length,
                          itemBuilder: (context, index) {
                            return FutureBuilder<QuerySnapshot>(
                              future: FirebaseFirestore.instance
                                  .collection('food_items')
                                  .where("itemId",
                                      whereIn: separateOrdersItemIds(
                                          (snapshots.data!.docs[index].data()!
                                                  as Map<String, dynamic>)[
                                              "productIds"]))
                                  .where("orderBy",
                                      whereIn:
                                          (snapshots.data!.docs[index].data()!
                                              as Map<String, dynamic>)['uid'])
                                  .orderBy("dateCreated", descending: true)
                                  .get(),
                              builder: (context, snap) {
                                return snap.hasData
                                    ? OrderCard(
                                        orderStatus: snapshots.data!.docs[index]
                                            .get("status"),
                                        itemCount: snap.data!.docs.length,
                                        data: snap.data!.docs,
                                        orderId: snapshots.data!.docs[index].id,
                                        separateItemQuantityList:
                                            separateOrderItemQuantity((snapshots
                                                        .data!.docs[index]
                                                        .data()!
                                                    as Map<String, dynamic>)[
                                                "productIds"]),
                                      )
                                    : Container();
                              },
                            );
                          },
                        )
                      : snapshots.data == null
                          ? const Center(
                              child: Text("You have no Ordere"),
                            )
                          : Center(
                              child: circularProgress(),
                            );
                },
              ),
            ),
            /* Container(
              color: primaryColor,
              padding: const EdgeInsets.all(10),
              child: const Center(
                child: Text(
                  "History",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            Container(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .doc(sharedPreferences!.getString("uid"))
                    .collection("orders")
                    .where("status", isEqualTo: "ended")
                    .orderBy("orderTime", descending: true)
                    .snapshots(),
                builder: (context, snapshots) {
                  return snapshots.hasData
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshots.data!.docs.length,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return FutureBuilder<QuerySnapshot>(
                              future: FirebaseFirestore.instance
                                  .collection('food_items')
                                  .where("itemId",
                                      whereIn: separateOrdersItemIds(
                                          (snapshots.data!.docs[index].data()!
                                                  as Map<String, dynamic>)[
                                              "productIds"]))
                                  .where("orderBy",
                                      whereIn:
                                          (snapshots.data!.docs[index].data()!
                                              as Map<String, dynamic>)['uid'])
                                  .orderBy("dateCreated", descending: true)
                                  .get(),
                              builder: (context, snap) {
                                return snap.hasData
                                    ? OrderCard(
                                        itemCount: snap.data!.docs.length,
                                        data: snap.data!.docs,
                                        orderId: snapshots.data!.docs[index].id,
                                        separateItemQuantityList:
                                            separateOrderItemQuantity((snapshots
                                                        .data!.docs[index]
                                                        .data()!
                                                    as Map<String, dynamic>)[
                                                "productIds"]),
                                      )
                                    : Container();
                              },
                            );
                          },
                        )
                      : Center(
                          child: circularProgress(),
                        );
                },
              ),
            ) */
          ],
        )
        /*  ListView(
        children: [
          Container(
            color: primaryColor,
            padding: const EdgeInsets.all(10),
            child: const Center(
              child: Text(
                "My Orders",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
         
        ],
      ), */
        );
  }
}
