import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as fstorage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:local_eat/components/error_dialog.dart';
import 'package:local_eat/components/loading_dialog.dart';
import 'package:local_eat/components/text_field.dart';
import 'package:local_eat/constants.dart';
import 'package:local_eat/global.dart';
import 'package:local_eat/splashScreen/main_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  XFile? imageXFile;
  final ImagePicker _picker = ImagePicker();

  String resturanteImageUrl = "";

  Future<void> _getImage() async {
    imageXFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageXFile;
    });
  }

  Future<void> formValidation() async {
    if (imageXFile == null) {
      showDialog(
        context: context,
        builder: (c) {
          return const ErrorDialog(
            message: "Please select an image.",
          );
        },
      );
    } else {
      if (name.text.isEmpty) {
        showDialog(
          context: context,
          builder: (c) {
            return const ErrorDialog(
              message: "Please, enter your resturant Name for Registration.",
            );
          },
        );
      } else if (phoneNumber.text.isEmpty) {
        showDialog(
          context: context,
          builder: (c) {
            return const ErrorDialog(
              message: "Please, enter resturant phone number for Registration.",
            );
          },
        );
      } else if (email.text.isEmpty) {
        showDialog(
          context: context,
          builder: (c) {
            return const ErrorDialog(
              message:
                  "Please, enter resturant email address for Registration.",
            );
          },
        );
      }
      if (password.text != confirmPassword.text) {
        showDialog(
          context: context,
          builder: (c) {
            return const ErrorDialog(
              message: "Please, your passwords do not match",
            );
          },
        );
      } else {
        if (password.text == confirmPassword.text) {
          if (confirmPassword.text.isNotEmpty &&
              email.text.isNotEmpty &&
              name.text.isNotEmpty &&
              phoneNumber.text.isNotEmpty) {
            //start uploading image
            showDialog(
              context: context,
              builder: (c) {
                return const LoadingDialog(
                  message: "Registering Account",
                );
              },
            );

            String fileName = DateTime.now().millisecondsSinceEpoch.toString();
            fstorage.Reference reference = fstorage.FirebaseStorage.instance
                .ref()
                .child("users")
                .child(fileName);
            fstorage.UploadTask uploadTask =
                reference.putFile(File(imageXFile!.path));
            fstorage.TaskSnapshot taskSnapshot =
                await uploadTask.whenComplete(() {});
            await taskSnapshot.ref.getDownloadURL().then(
              (url) {
                resturanteImageUrl = url;

                //save info to firestore
                authenticateResturantAndSignUp();
              },
            );
          }
        } else {
          showDialog(
            context: context,
            builder: (c) {
              return const ErrorDialog(
                message: "Password do not match.",
              );
            },
          );
        }
      }
    }
  }

  void authenticateResturantAndSignUp() async {
    User? currentUser;
    await firebaseAuth
        .createUserWithEmailAndPassword(
      email: email.text.trim(),
      password: password.text.trim(),
    )
        .then((auth) {
      currentUser = auth.user;
    }).catchError(
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
      saveDataToFirestore(currentUser!).then(
        (value) {
          Navigator.pop(context);
          //send user to homePage
          Route newRoute = MaterialPageRoute(builder: (c) => const MainPage());
          Navigator.pushReplacement(context, newRoute);
        },
      );
    }
  }

  Future saveDataToFirestore(User currentUser) async {
    FirebaseFirestore.instance.collection("users").doc(currentUser.uid).set(
      {
        "uid": currentUser.uid,
        "email": currentUser.email,
        "name": name.text.trim(),
        "photoUrl": resturanteImageUrl,
        "phone": phoneNumber.text.trim(),
        "status": "approved",
        "userCart": ['garbageValue']
      },
    );

    //save data locally
    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences!.setString("uid", currentUser.uid);
    await sharedPreferences!
        .setString("userEmail", currentUser.email.toString());
    await sharedPreferences!.setString("username", name.text.trim());
    await sharedPreferences!.setString("photoUrl", resturanteImageUrl);
    await sharedPreferences!.setStringList("userCart", ['garbageValue']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        leading: const Icon(Icons.arrow_back, color: primaryColor,),
        backgroundColor: primaryColor,
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 15,
          ),
          /*  Center(
            child: Image.asset('assets/images/signup.png'),
          ),
          const SizedBox(
            height: 20,
          ), */
          const Center(
            child: Text(
              "SignUp",
              style: TextStyle(
                color: blackColor,
                fontSize: 35,
              ),
            ),
          ),
          Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  _getImage();
                },
                child: CircleAvatar(
                  radius: MediaQuery.of(context).size.width * 0.20,
                  backgroundColor: Colors.white,
                  backgroundImage: imageXFile == null
                      ? null
                      : FileImage(File(imageXFile!.path)),
                  child: imageXFile == null
                      ? Icon(
                          Icons.add_photo_alternate,
                          size: MediaQuery.of(context).size.width * 0.20,
                          color: Colors.grey,
                        )
                      : null,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      data: Icons.person,
                      controller: name,
                      label: "Name",
                      isObsecre: false,
                    ),
                    CustomTextField(
                      data: Icons.phone,
                      controller: phoneNumber,
                      label: "Phone Number",
                      isObsecre: false,
                      keyboardType: TextInputType.number,
                    ),
                    CustomTextField(
                      data: Icons.mail,
                      controller: email,
                      label: "Email",
                      isObsecre: false,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    CustomTextField(
                      data: Icons.lock,
                      controller: password,
                      label: "Password",
                      isObsecre: true,
                    ),
                    CustomTextField(
                      data: Icons.lock,
                      controller: confirmPassword,
                      label: "Confirm Password",
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
                        "Register Account",
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
        ],
      ),
    );
  }
}
