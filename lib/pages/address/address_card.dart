import 'package:flutter/material.dart';
import 'package:local_eat/components/maps.dart';
import 'package:local_eat/constants.dart';
import 'package:local_eat/functions/address_changer.dart';
import 'package:local_eat/functions/functions.dart';
import 'package:local_eat/global.dart';
import 'package:local_eat/models/address_model.dart';
import 'package:local_eat/splashScreen/main_page.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddressCard extends StatefulWidget {
  final Address? model;
  final int currentIndex;
  final int value;
  final String? addressId;
  final double? totalAmount;
  final String? resturantUid;
  const AddressCard({
    Key? key,
    required this.currentIndex,
    required this.value,
    this.model,
    this.addressId,
    this.totalAmount,
    this.resturantUid,
  }) : super(key: key);

  @override
  State<AddressCard> createState() => _AddressCardState();
}

class _AddressCardState extends State<AddressCard> {
  String orderId = DateTime.now().millisecondsSinceEpoch.toString();

  saveOrder() {
    writeOrderDetailsUser({
      "addressId": widget.addressId,
      "totalAmount": widget.totalAmount,
      "orderBy": sharedPreferences!.getString("uid"),
      "productIds": sharedPreferences!.getStringList("userCart"),
      "orderTime": orderId,
      "paymentOption": "Cash on Delivery",
      "resturantUid": widget.resturantUid,
      "isSuccess": true,
      "riderUid": "",
      "status": "normal",
    });

    writeOrderDetailsResturant({
      "addressId": widget.addressId,
      "totalAmount": widget.totalAmount,
      "orderBy": sharedPreferences!.getString("uid"),
      "productIds": sharedPreferences!.getStringList("userCart") ?? "",
      "orderTime": orderId,
      "paymentOption": "Cash on Delivery",
      "resturantUid": widget.resturantUid,
      "isSuccess": true,
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

  deleteAddress() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(sharedPreferences!.getString("uid"))
        .collection("userAddress")
        .doc(widget.addressId)
        .delete()
        .then((value) {
      Fluttertoast.showToast(msg: "Address succesfful deleted");
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Provider.of<AddressChanger>(context, listen: false)
            .displayResults(widget.value);
      },
      child: Card(
        elevation: 7,
        shadowColor: const Color.fromARGB(110, 0, 0, 0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Radio(
                  groupValue: widget.currentIndex,
                  value: widget.value,
                  activeColor: primaryColor,
                  onChanged: (val) {
                    Provider.of<AddressChanger>(context, listen: false)
                        .displayResults(val);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.model!.name.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.model!.phoneNumber.toString(),
                      ),
                      SizedBox(
                        width: 250,
                        child: Text(
                          widget.model!.fullAddress.toString(),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          MapsUtils.openMapWithPosition(
                            widget.model!.lat!,
                            widget.model!.lng!,
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Icon(Icons.person_pin_circle),
                            Text("View Address location")
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    /* IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.edit,
                      ),
                    ), */
                    IconButton(
                      onPressed: () {
                        deleteAddress();
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    )
                  ],
                )
              ],
            ),
            widget.value == Provider.of<AddressChanger>(context).count
                ? Padding(
                    padding: const EdgeInsets.only(
                      top: 5,
                      left: 20,
                      right: 20,
                      bottom: 10,
                    ),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        saveOrder();
                      },
                      icon: const Icon(
                        Icons.delivery_dining,
                        color: Colors.white,
                      ),
                      label: const Text(
                        "Complete Order",
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
                : Container(),
          ],
        ),
      ),
    );
  }
}
