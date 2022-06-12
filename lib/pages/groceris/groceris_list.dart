import 'package:flutter/material.dart';
import 'package:local_eat/components/search_box.dart';
import 'package:local_eat/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GrocerisList extends StatelessWidget {
  const GrocerisList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFfcc833),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
          color: Colors.white,
        ),
        title: RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: "Groceries",
                style:
                    TextStyle(color: blackColor, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: SvgPicture.asset("assets/icons/notification.svg"),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        children: [
          Center(
            child: SearchBox(onChanged: ((value) => {})),
          )
        ],
      ),
    );
  }
}
