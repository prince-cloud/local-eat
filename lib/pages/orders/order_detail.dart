import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:local_eat/components/progress_bar.dart';
import 'package:local_eat/components/shipment_address_card.dart';
import 'package:local_eat/components/status_banner.dart';
import 'package:local_eat/constants.dart';
import 'package:local_eat/global.dart';
import 'package:intl/intl.dart';
import 'package:local_eat/models/address_model.dart';

class OrderDetail extends StatefulWidget {
  final String? orderId;

  const OrderDetail({Key? key, this.orderId}) : super(key: key);

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  String orderStatus = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection("users")
              .doc(sharedPreferences!.getString("uid"))
              .collection("orders")
              .doc(widget.orderId)
              .get(),
          builder: (context, snapshot) {
            Map? dataMap;
            if (snapshot.hasData) {
              dataMap = snapshot.data!.data()! as Map<String, dynamic>;
              orderStatus = dataMap["status"].toString();
            }
            return snapshot.hasData
                ? Container(
                    padding: const EdgeInsets.only(top: 36),
                    child: Column(
                      children: [
                        StatusBanner(
                          status: dataMap!["isSuccess"],
                          orderStatus: orderStatus,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Total Amount: GHC " +
                              dataMap["totalAmount"].toString(),
                          style: const TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          "order ID: " + widget.orderId.toString(),
                          style: const TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "Ordered on: " +
                              DateFormat("dd MMMM, yyyy - hh:mm aa").format(
                                DateTime.fromMillisecondsSinceEpoch(
                                  int.parse(
                                    dataMap["orderTime"],
                                  ),
                                ),
                              ),
                          style: const TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const Divider(
                          thickness: 2,
                          color: Color.fromARGB(82, 0, 0, 0),
                        ),
                        orderStatus == "normal"
                            ? Column(
                                children: [
                                  Image.asset(
                                    "assets/images/packing.png",
                                    width: 150,
                                    height: 150,
                                  ),
                                  const Text(
                                    "Your Order has been Received",
                                  )
                                ],
                              )
                            : orderStatus == "packaged"
                                ? Column(
                                    children: [
                                      Image.asset(
                                        "assets/images/packed.png",
                                        width: 150,
                                        height: 150,
                                      ),
                                      const Text(
                                        "Your Order has been Packaged",
                                      )
                                    ],
                                  )
                                : orderStatus == "inTransit"
                                    ? Column(
                                        children: [
                                          Image.asset(
                                            "assets/images/transit.png",
                                            width: 150,
                                            height: 150,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Text(
                                            "Package in Transit",
                                          )
                                        ],
                                      )
                                    : Column(
                                        children: [
                                          Image.asset(
                                            "assets/images/delivered.png",
                                            width: 150,
                                            height: 150,
                                          ),
                                          const Text(
                                            "Order Delivered",
                                          )
                                        ],
                                      ),
                        const Divider(
                          thickness: 2,
                          color: Color.fromARGB(82, 0, 0, 0),
                        ),
                        FutureBuilder<DocumentSnapshot>(
                          future: FirebaseFirestore.instance
                              .collection("users")
                              .doc(sharedPreferences!.getString("uid"))
                              .collection("userAddress")
                              .doc(dataMap["addressId"])
                              .get(),
                          builder: (context, snapshot) {
                            return snapshot.hasData
                                ? ShipmentAddressCard(
                                    model: Address.fromJson(
                                      snapshot.data?.data()
                                          as Map<String, dynamic>,
                                    ),
                                  )
                                : Center(
                                    child: circularProgress(),
                                  );
                          },
                        ),
                        const Divider(
                          thickness: 2,
                          color: Color.fromARGB(82, 0, 0, 0),
                        ),
                      ],
                    ),
                  )
                : Container();
          },
        ),
      ),
    );
  }
}
