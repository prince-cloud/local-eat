import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:local_eat/functions/functions.dart';
import 'package:local_eat/global.dart';
import 'package:local_eat/splashScreen/main_page.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PlacedOrder extends StatefulWidget {
  String? addressId;
  double? totalAmount;
  String? resturantUid;
  PlacedOrder({Key? key, this.addressId, this.totalAmount, this.resturantUid})
      : super(key: key);

  @override
  State<PlacedOrder> createState() => _PlacedOrderState();
}

class _PlacedOrderState extends State<PlacedOrder> {
  String orderId = DateTime.now().millisecondsSinceEpoch.toString();

  saveOrder() {
    writeOrderDetailsUser({
      "addressId": widget.addressId,
      "totalAmount": widget.totalAmount,
      "orderBy": sharedPreferences!.getString("uid"),
      "productIds": sharedPreferences!.getStringList("userCart"),
      "orderTime": DateTime.now().toString(),
      "paymentOption": "Cash on Delivery",
      "resturantUid": widget.resturantUid,
      "orderSucess": "Yes",
      "riderUid": "",
      "status": "normal",
    });

    writeOrderDetailsResturant({
      "addressId": widget.addressId,
      "totalAmount": widget.totalAmount,
      "orderBy": sharedPreferences!.getString("uid"),
      "productIds": sharedPreferences!.getStringList("userCart") ?? "",
      "orderTime": DateTime.now().toString(),
      "paymentOption": "Cash on Delivery",
      "resturantUid": widget.resturantUid,
      "orderSucess": "Yes",
      "riderUid": "",
      "status": "normal",
    }).whenComplete(() {
      clearCart(context);
      setState(() {
        orderId = "";
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MainPage(),
          ),
        );
        Fluttertoast.showToast(msg: "Order successfully placed");
      });
    });
  }

  Future writeOrderDetailsUser(Map<String, dynamic> data) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(sharedPreferences!.getString("uid"))
        .collection("orders")
        .doc(orderId)
        .set(data);
  }

  Future writeOrderDetailsResturant(Map<String, dynamic> data) async {
    await FirebaseFirestore.instance
        .collection("orders")
        .doc(orderId)
        .set(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFfcc833),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
          color: Colors.black,
        ),
        title: const Text(
          "Placed Order",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(
            child: ElevatedButton.icon(
              onPressed: () {
                saveOrder();
              },
              icon: const Icon(
                Icons.delivery_dining,
                color: Colors.white,
              ),
              label: const Text(
                "Place Order",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: const Color.fromARGB(255, 0, 141, 12),
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 10,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
