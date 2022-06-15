// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final IconData? data;
  final String? label;
  final TextInputType? keyboardType;
  bool? isObsecre = true;
  bool? enabled = true;

  CustomTextField({
    Key? key,
    this.controller,
    this.data,
    this.label,
    this.isObsecre,
    this.enabled,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(10),
      child: TextFormField(
        keyboardType: keyboardType,
        enabled: enabled,
        controller: controller,
        obscureText: isObsecre!,
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            data,
            color: const Color.fromARGB(255, 245, 180, 3),
          ),
          focusColor: Theme.of(context).primaryColor,
          label: Text(label!),
        ),
      ),
    );
  }
}

class CustomAddressTextField extends StatelessWidget {
  final TextEditingController? controller;
  final IconData? data;
  final String? label;
  final TextInputType? keyboardType;
  bool? enabled = true;

  CustomAddressTextField({
    Key? key,
    this.controller,
    this.data,
    this.label,
    this.enabled,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      padding: const EdgeInsets.only(top: 3, left: 20, right: 10, bottom: 3),
      margin: const EdgeInsets.all(5),
      child: TextFormField(
        keyboardType: keyboardType,
        enabled: enabled,
        controller: controller,
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(
          border: InputBorder.none,
          /* prefixIcon: Icon(
            data,
            color: Color.fromARGB(255, 0, 0, 0),
          ), */
          focusColor: Theme.of(context).primaryColor,
          label: Text(label!),
        ),
        validator: (value) =>
            value!.isEmpty ? '${label!} cannot be empty' : null,
      ),
    );
  }
}
