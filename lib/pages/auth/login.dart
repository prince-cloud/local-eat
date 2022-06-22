import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:local_eat/components/error_dialog.dart';
import 'package:local_eat/components/loading_dialog.dart';
import 'package:local_eat/components/text_field.dart';
import 'package:local_eat/constants.dart';
import 'package:local_eat/global.dart';
import 'package:local_eat/splashScreen/main_page.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  formValidation() {
    if (email.text.isNotEmpty && password.text.isNotEmpty) {
      //login
      loginNow();
    } else {
      showDialog(
        context: context,
        builder: (c) {
          return const ErrorDialog(
            message: "Please enter email/password.",
          );
        },
      );
    }
  }

  loginNow() async {
    showDialog(
      context: context,
      builder: (c) {
        return const LoadingDialog(
          message: "Checking Credentials",
        );
      },
    );

    User? currentUser;
    await firebaseAuth
        .signInWithEmailAndPassword(
      email: email.text.trim(),
      password: password.text.trim(),
    )
        .then(
      (auth) {
        currentUser = auth.user!;
      },
    ).catchError(
      (error) {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (c) {
            return ErrorDialog(
              message: error.message.toString(),
            );
          },
        );
      },
    );
    if (currentUser != null) {
      readDataAndSetDataLocally(currentUser!);
    }
  }

  Future readDataAndSetDataLocally(User currentUser) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser.uid)
        .get()
        .then(
      (snapshot) async {
        if (snapshot.exists) {
          await sharedPreferences!.setString("uid", currentUser.uid);
          await sharedPreferences!
              .setString("userEmail", snapshot.data()?["email"] ?? "");
          await sharedPreferences!
              .setString("username", snapshot.data()?["name"] ?? "");
          await sharedPreferences!
              .setString("photoUrl", snapshot.data()?["photoUrl"] ?? "");

          List<String> userCartList =
              snapshot.data()!["userCart"].cast<String>();
          await sharedPreferences!.setStringList("userCart", userCartList);

          // ignore: use_build_context_synchronously
          Navigator.pop(context);

          // ignore: use_build_context_synchronously
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (c) => const MainPage(),
            ),
          );
        } else {
          firebaseAuth.signOut();
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (c) => const LogIn(),
            ),
          );
          showDialog(
            context: context,
            builder: (c) {
              return const ErrorDialog(
                message: "Your record does not exists",
              );
            },
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back, color: primaryColor,),
        backgroundColor: primaryColor,
      ),
      body: ListView(children: [
        const SizedBox(
          height: 15,
        ),
        Center(
          child: Image.asset(
            'assets/images/login.png',
            height: 170,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Center(
          child: Text(
            "LogIn",
            style: TextStyle(
              color: blackColor,
              fontSize: 35,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    data: Icons.person,
                    controller: email,
                    label: "Email",
                    isObsecre: false,
                  ),
                  CustomTextField(
                    data: Icons.lock,
                    controller: password,
                    label: "Password",
                    isObsecre: true,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 0, 0, 0),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 10,
                      ),
                    ),
                    onPressed: () {
                      formValidation();
                    },
                    child: const Text(
                      "Log In",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ],
        )
      ]),
    );
  }
}
