import 'package:flutter/material.dart';
import 'package:local_eat/components/app_bar.dart';
import 'package:local_eat/constants.dart';
import 'package:local_eat/pages/auth/login.dart';
import 'package:local_eat/pages/auth/signup.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* appBar: AppBar(
        leading: const Icon(Icons.arrow_back, color: whiteColor,),
        backgroundColor: whiteColor,
        shadowColor: whiteColor,
        
      ), */
      
      body: ListView(
        children: [
          const SizedBox(
            height: 100,
          ),
          Center(
            child: Image.asset('assets/images/auth.png', height: 150,),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: 50,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(255, 0, 0, 0),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 50,
                          vertical: 10,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LogIn(),
                          ),
                        );
                      },
                      icon: Icon(Icons.lock_open, color: whiteColor,), 
                      label: Text("Log In", style: TextStyle(color: whiteColor),),
                      /* child: const Text(
                        "Log In",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ), */
                    ),
                  ),
                  const Padding(padding:  EdgeInsets.all(20), child: Text("OR"),),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: 50,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(255, 0, 0, 0),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 50,
                          vertical: 10,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUp(),
                          ),
                        );
                      }, 
                      icon: Icon(Icons.lock, color: whiteColor,), 
                      label: Text("Sign Up", style: TextStyle(color: whiteColor),),
                      /* child: const Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ), */
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
