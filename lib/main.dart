import 'package:flutter/material.dart';
import 'package:local_eat/functions/address_changer.dart';
import 'package:local_eat/functions/cart_item_counter.dart';
import 'package:local_eat/functions/total_order_amount.dart';
import 'package:local_eat/global.dart';
import 'package:local_eat/splashScreen/main_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (c) => CartItemCounter()),
        ChangeNotifierProvider(create: (c) => TotalOrderAmount()),
        ChangeNotifierProvider(create: (c) => AddressChanger()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Local Eat',
        theme: ThemeData(
          primarySwatch: Colors.yellow,
          backgroundColor: const Color(0xFFf1f5ff),
        ),
        home: const MainPage(),
      ),
    );
  }
}
