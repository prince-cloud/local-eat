import 'package:flutter/material.dart';
import 'package:local_eat/components/text_field.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:local_eat/global.dart';
import 'package:local_eat/models/address_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddNewAddress extends StatefulWidget {
  const AddNewAddress({Key? key}) : super(key: key);

  @override
  State<AddNewAddress> createState() => _AddNewAddressState();
}

class _AddNewAddressState extends State<AddNewAddress> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _flatNumber = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _state = TextEditingController();
  final TextEditingController _completeAddress = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  List<Placemark>? placemarks;

  bool isLoading = false;

  Position? position;

  getUserCurrentLocation() async {
    /*  showDialog(
      context: context,
      builder: (c) {
        return const LoadingDialog(
          message: "getting current location",
        );
      },
    ); */
    Position newPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    position = newPosition;

    placemarks = await placemarkFromCoordinates(
      newPosition.latitude,
      newPosition.longitude,
    );

    Placemark pMark = placemarks![0];

    // add to full address to get actual location
    // '${pMark.subThoroughfare} ${pMark.thoroughfare}'
    String fullAddress =
        '${pMark.subLocality} ${pMark.locality}, ${pMark.subAdministrativeArea} ${pMark.administrativeArea}, ${pMark.postalCode}, ${pMark.country}';

    _locationController.text = fullAddress;
    _flatNumber.text =
        '${pMark.subThoroughfare} ${pMark.thoroughfare}, ${pMark.subLocality} ${pMark.locality}';
    _city.text =
        '${pMark.subAdministrativeArea} ${pMark.administrativeArea}, ${pMark.postalCode}';
    _state.text = '${pMark.country}';
    _completeAddress.text = fullAddress;

    setState(() {
      isLoading == false;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserCurrentLocation();
  }

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
        title: const Text("Add New Address",
            style: TextStyle(color: Colors.black)),
      ),
      body: ListView(
        children: [
          /* ListTile(
            leading: const Icon(
              Icons.person_pin_circle,
              size: 40,
            ),
            title: TextField(
              controller: _locationController,
              decoration: const InputDecoration(
                label: Text("What's your address"),
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              getUserCurrentLocation();
            },
            icon: const Icon(Icons.my_location),
            label: const Text("Get current location"),
          ), */
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Column(
              children: const [
                /* Text(
                  "New Address",
                  style: TextStyle(
                    color: blackColor,
                    fontSize: 35,
                  ),
                ), */
                Text(
                  "Your current location will be used for other fields",
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Form(
            key: formKey,
            child: Column(
              children: [
                CustomAddressTextField(
                  controller: _name,
                  label: "Name",
                ),
                CustomAddressTextField(
                  controller: _phoneNumber,
                  label: "Phone Number",
                  keyboardType: TextInputType.number,
                ),
                CustomAddressTextField(
                  controller: _city,
                  label: "City",
                  enabled: false,
                ),
                CustomAddressTextField(
                  controller: _state,
                  label: "Stae/Country",
                  enabled: false,
                ),
                CustomAddressTextField(
                  controller: _flatNumber,
                  label: "Address Line",
                  enabled: false,
                ),
                CustomAddressTextField(
                  controller: _completeAddress,
                  label: "Complete Address",
                  enabled: false,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton.icon(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  final model = Address(
                    name: _name.text.trim(),
                    phoneNumber: _phoneNumber.text.trim(),
                    state: _state.text.trim(),
                    fullAddress: _completeAddress.text.trim(),
                    flatNumber: _flatNumber.text.trim(),
                    city: _city.text.trim(),
                    lat: position?.latitude,
                    lng: position?.longitude,
                  ).toJson();

                  FirebaseFirestore.instance
                      .collection("users")
                      .doc(firebaseAuth.currentUser!.uid)
                      .collection("userAddress")
                      .doc(DateTime.now().microsecondsSinceEpoch.toString())
                      .set(model)
                      .then(
                    (value) {
                      Fluttertoast.showToast(msg: "New Address Saved");

                      formKey.currentState!.reset();
                    },
                  );
                }
              },
              icon: const Icon(
                Icons.save,
                color: Colors.white,
              ),
              label: const Text(
                "Save Address",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: const Color.fromARGB(255, 0, 0, 0),
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 10,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
