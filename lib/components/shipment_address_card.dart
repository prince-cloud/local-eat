import 'package:flutter/material.dart';
import 'package:local_eat/models/address_model.dart';

class ShipmentAddressCard extends StatelessWidget {
  final Address? model;
  const ShipmentAddressCard({Key? key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 20),
          width: MediaQuery.of(context).size.width,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Delivery address",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      model!.name.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      model!.phoneNumber.toString(),
                    ),
                    SizedBox(
                      width: 250,
                      child: Text(
                        model!.fullAddress.toString(),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
