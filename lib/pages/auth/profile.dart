import 'package:flutter/material.dart';
import 'package:local_eat/constants.dart';
import 'package:local_eat/global.dart';
import 'package:local_eat/pages/address/add_new_address.dart';
import 'package:local_eat/pages/orders/history.dart';
import 'package:local_eat/splashScreen/main_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf1f5ff),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 20, top: 10, bottom: 20),
            color: primaryColor,
            child: Row(
              children: [
                SizedBox(
                  width: 70,
                  height: 70,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      sharedPreferences!.getString("photoUrl").toString(),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sharedPreferences!.getString("username").toString(),
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      sharedPreferences!.getString("userEmail").toString(),
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          ListTile(
            leading: const Icon(Icons.access_time),
            title: const Text(
              "History",
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const OrderHistory(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_location),
            title: const Text(
              "New Address",
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddNewAddress(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text("Log Out"),
            onTap: () {
              firebaseAuth.signOut().then(
                    (value) => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MainPage(),
                        ),
                      ),
                    },
                  );
            },
          ),
        ],
      ),
    );
  }
}
