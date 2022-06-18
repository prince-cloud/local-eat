import 'package:flutter/material.dart';
import 'package:local_eat/components/app_bar.dart';
import 'package:local_eat/global.dart';
import 'package:local_eat/pages/auth/auth_screen.dart';
import 'package:local_eat/pages/auth/profile.dart';
import 'package:local_eat/pages/homepage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:local_eat/pages/orders/my_orders.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List pages = [
    const HomePage(),
    const MyOrders(),
    if (firebaseAuth.currentUser != null) const ProfilePage(),
    if (firebaseAuth.currentUser == null) const AuthScreen(),
  ];

  int currentIndex = 0;

  void onTap(int index) {
    setState(
      () {
        currentIndex = index;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    //clearCart(context);
    //Fluttertoast.showToast(msg: "Orders cleared");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf1f5ff),
      appBar: homeAppBar(context),
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          content: Text('Tap again to close app'),
        ),
        child: pages[currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        selectedItemColor: Colors.black54,
        unselectedItemColor: const Color.fromARGB(104, 29, 29, 29),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedLabelStyle: const TextStyle(
          color: Colors.black54,
          fontWeight: FontWeight.bold,
        ),
        items: [
          BottomNavigationBarItem(
            label: "Home",
            icon: SvgPicture.asset("assets/icons/home2.svg"),
          ),
          BottomNavigationBarItem(
            label: "Orders",
            icon: SvgPicture.asset("assets/icons/Glyph.svg"),
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: SvgPicture.asset("assets/icons/person.svg"),
          ),
        ],
      ),
      //floatingActionButton: customCartButtom(context),
    );
  }
}
