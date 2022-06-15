import 'package:flutter/material.dart';
import 'package:local_eat/components/progress_bar.dart';
import 'package:local_eat/constants.dart';
import 'package:local_eat/functions/address_changer.dart';
import 'package:local_eat/global.dart';
import 'package:local_eat/models/address_model.dart';
import 'package:local_eat/pages/address/add_new_address.dart';
import 'package:local_eat/pages/address/address_card.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdressPage extends StatefulWidget {
  final double totAlamount;
  final String resturantUid;

  const AdressPage(
      {Key? key, required this.totAlamount, required this.resturantUid})
      : super(key: key);

  @override
  State<AdressPage> createState() => _AdressPageState();
}

class _AdressPageState extends State<AdressPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf1f5ff),
      appBar: AppBar(
        backgroundColor: const Color(0xFFfcc833),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
          color: Colors.black,
        ),
        title: const Text("Address", style: TextStyle(color: Colors.black)),
      ),
      body: ListView(
        children: [
          Container(
            color: primaryColor,
            padding: const EdgeInsets.only(bottom: 15, top: 10),
            child: ListTile(
              title: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddNewAddress(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.my_location,
                  color: Colors.white,
                ),
                label: const Text(
                  "add new address",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.transparent,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 10,
                  ),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(15),
            child: Text(
              "Select Address",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Consumer<AddressChanger>(
            builder: (context, address, c) {
              return StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .doc(firebaseAuth.currentUser!.uid)
                    .collection("userAddress")
                    .snapshots(),
                builder: (context, snapshot) {
                  return !snapshot.hasData
                      ? Center(
                          child: circularProgress(),
                        )
                      : snapshot.data!.docs.isEmpty
                          ? Container()
                          : ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return AddressCard(
                                  currentIndex: address.count,
                                  value: index,
                                  addressId: snapshot.data!.docs[index].id,
                                  totalAmount: widget.totAlamount,
                                  resturantUid: widget.resturantUid,
                                  model: Address.fromJson(
                                    snapshot.data!.docs[index].data()!
                                        as Map<String, dynamic>,
                                  ),
                                );
                              },
                            );
                },
              );
            },
          )
        ],
      ),
    );
  }
}
