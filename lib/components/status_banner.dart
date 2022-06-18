import 'package:flutter/material.dart';
import 'package:local_eat/constants.dart';

class StatusBanner extends StatelessWidget {
  final bool status;
  final String orderStatus;
  const StatusBanner(
      {Key? key, required this.status, required this.orderStatus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String message;
    IconData iconData;

    status ? iconData = Icons.done : iconData = Icons.cancel;
    status ? message = "Successful" : message = "Unsuccessful";

    return Container(
      color: primaryColor,
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
            ),
          ),
          Text(
            orderStatus == "ended"
                ? "Packaged Delevered "
                : orderStatus == "packaged"
                    ? "Order Packaged"
                    : orderStatus == "inTransit"
                        ? "Order in Transit"
                        : "Order Placed",
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          const Icon(
            Icons.check_circle,
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}
