import 'package:flutter/material.dart';
import 'package:local_eat/components/search_box.dart';
import 'package:local_eat/models/groceries_model.dart';
import 'package:local_eat/models/grocery_shop_model.dart';
import 'package:local_eat/network_api.dart';
import 'package:local_eat/providers/groceries_list_provider.dart';
import 'package:local_eat/providers/grocery_shop_list_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_eat/constants.dart';

class GroceryShopDetail extends StatefulWidget {
  final GroceryShop groceryShop;
  const GroceryShopDetail({Key? key, required this.groceryShop})
      : super(key: key);

  @override
  State<GroceryShopDetail> createState() => _GroceryShopDetailState();
}

class _GroceryShopDetailState extends State<GroceryShopDetail> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => GroceryShopProvider()..fetchData(),
      builder: (BuildContext context, _) {
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
                    style: TextStyle(
                        color: blackColor, fontWeight: FontWeight.bold),
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
          body: Consumer<GroceryShopProvider>(
            builder: (context, groceriesProvider, _) {
              return RefreshIndicator(
                onRefresh: () async {
                  groceriesProvider.fetchData();
                },
                child: ListView(
                  children: [
                    Center(
                      child: SearchBox(
                        onChanged: (value) {},
                      ),
                    ),
                    FutureBuilder<List<Groceries>>(
                      future:
                          apiClient.fetchGroceries(id: widget.groceryShop.id),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Groceries>> grocery) {
                        return Column(
                          children: [
                            if (grocery.hasError)
                              Center(
                                child: Text(grocery.error.toString()),
                              ),
                            if (grocery.data != null)
                              ...grocery.data!.map(
                                (grocery) {
                                  return GestureDetector(
                                    onTap: () {
                                      print(grocery.name + " tapped");
                                    },
                                    child: Card(
                                      elevation: 7,
                                      shadowColor:
                                          const Color.fromARGB(96, 0, 0, 0),
                                      child: ListTile(
                                        leading: Image.network(
                                          grocery.image,
                                          width: 70,
                                          height: 200,
                                          fit: BoxFit.contain,
                                        ),
                                        title: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              grocery.name,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black54,
                                              ),
                                            ),
                                            Text(grocery.description),
                                          ],
                                        ),
                                        subtitle: Text("GHC " + grocery.price),
                                        trailing: const Icon(Icons.arrow_right),
                                      ),
                                    ),
                                  );
                                },
                              ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
