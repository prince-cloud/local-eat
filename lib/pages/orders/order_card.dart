import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:local_eat/constants.dart';
import 'package:local_eat/models/food_model.dart';
import 'package:local_eat/pages/orders/order_detail.dart';

class OrderCard extends StatelessWidget {
  final int? itemCount;
  final List<DocumentSnapshot>? data;
  final String? orderId;
  final List<String>? separateItemQuantityList;
  final String? orderStatus;

  const OrderCard({
    Key? key,
    this.itemCount,
    this.data,
    this.orderId,
    this.separateItemQuantityList,
    this.orderStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderDetail(
              orderId: orderId,
            ),
          ),
        );
      },
      child: Card(
        elevation: 7,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 120,
                color: orderStatus == "ended"
                    ? Colors.black
                    : orderStatus == "packaged"
                        ? primaryColor
                        : orderStatus == "inTransit"
                            ? Colors.teal
                            : Colors.green,
                padding: const EdgeInsets.all(5),
                child: Text(
                  orderStatus == "ended"
                      ? "Packaged Delevered "
                      : orderStatus == "packaged"
                          ? "Order Packaged"
                          : orderStatus == "inTransit"
                              ? "Order in Transit"
                              : "Order Placed",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: orderStatus == "ended"
                        ? Colors.white
                        : orderStatus == "inTransit"
                            ? Colors.white
                            : Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: itemCount,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    FoodItems model = FoodItems.fromJson(
                        data![index].data()! as Map<String, dynamic>);
                    return placedOrderDesign(
                      model,
                      context,
                      separateItemQuantityList![index],
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget placedOrderDesign(
    FoodItems model, BuildContext context, separateItemQuantityList) {
  return Container(
    color: const Color.fromARGB(255, 235, 235, 235),
    child: InkWell(
      child: ListTile(
        title: Text(
          model.itemTitle.toString(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          "x " + separateItemQuantityList.toString(),
        ),
        trailing: Text(
          "GHC " +
              (model.price! * int.parse(separateItemQuantityList)).toString(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.orange,
          ),
        ),
      ),
    ),
  );
}
