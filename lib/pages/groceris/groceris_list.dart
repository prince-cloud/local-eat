import 'package:flutter/material.dart';
import 'package:local_eat/components/search_box.dart';
import 'package:local_eat/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_eat/providers/groceries_list_provider.dart';
import 'package:provider/provider.dart';

class GrocerisList extends StatelessWidget {
  const GrocerisList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => GroceriesProvider()..fetchData(),
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
          body: Consumer<GroceriesProvider>(
              builder: (context, groceriesProvider, _) {
            return RefreshIndicator(
              onRefresh: () async {
                groceriesProvider.fetchData();
              },
              child: ListView(
                children: [
                  Center(
                    child: SearchBox(onChanged: (value) => {}),
                  ),
                  ...(groceriesProvider.groceries).map(
                    (grocery) {
                      return Card(
                        elevation: 7,
                        shadowColor: Color.fromARGB(96, 0, 0, 0),
                        child: ListTile(
                          leading: Image.network(
                            grocery.image,
                            width: 70,
                            height: 200,
                            fit: BoxFit.contain,
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                      );
                    },
                  ),
                ],
              ),
            );
          }),
        );
      },
    );
  }
}
