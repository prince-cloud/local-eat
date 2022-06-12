import 'package:flutter/material.dart';
import 'package:local_eat/auth/auth_screen.dart';
import 'package:local_eat/auth/profile.dart';
import 'package:local_eat/components/app_bar.dart';
import 'package:local_eat/functions/functions.dart';
import 'package:local_eat/global.dart';
import 'package:local_eat/pages/history.dart';
import 'package:local_eat/pages/homepage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List pages = [
    const HomePage(),
    const HistoryPage(),
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
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        selectedItemColor: Colors.black54,
        unselectedItemColor: const Color.fromARGB(104, 29, 29, 29),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        showSelectedLabels: true,
        showUnselectedLabels: false,
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
            label: "History",
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
