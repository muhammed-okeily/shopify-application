// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously, avoid_print

import 'package:animate_do/animate_do.dart';
import 'package:buying/constants.dart';
import 'package:buying/screens/user/HomeScreen.dart';
import 'package:buying/screens/signupSceen.dart';
import 'package:buying/services/auth.dart';
import 'package:buying/widget/customLogo.dart';
import 'package:buying/widget/customTextField.dart';
import 'package:firebaseapis/firestore/v1.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../provider/admin.dart';
import 'admin/adminHomeScreen.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  bool isAdmin = false;

  String? email, password;

  final adminPassword = 'admin123';

  bool keepMeLoggedIn = false;

  final auth = Auth();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kMainColor,
      body: Form(
        key: globalKey,
        child: ListView(
          children: [
            FadeInDown(child: CustomLogo()),
            SizedBox(
              height: height * .1,
            ),
            CustomTextField(
                onClick: (value) {
                  email = value;
                },
                hint: 'Enter your email ..',
                icon: Icons.email_rounded),
            SizedBox(
              height: height * .03,
            ),
            CustomTextField(
                onClick: (value) {
                  password = value;
                },
                hint: 'Enter your password ..',
                icon: Icons.lock_clock_rounded),
            SizedBox(
              height: height * .04,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 120),
              child: Container(
                /*       decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xff0DF5E3),
                      blurRadius: 10.0,
                      spreadRadius: 5,
                      offset: Offset(0, 5),
                    )
                  ],
                ),*/
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  onPressed: () {
                    if (keepMeLoggedIn == true) {
                      keepUserLoggedIn();
                    }
                    Validate(context);
                  },
                  child: Text('Login'.toUpperCase(),
                      style: GoogleFonts.lato(color: Colors.white)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Row(
                children: [
                  Theme(
                    data: ThemeData(unselectedWidgetColor: Colors.white),
                    child: Checkbox(
                        checkColor: kSecondaryColor,
                        activeColor: Colors.black,
                        value: keepMeLoggedIn,
                        onChanged: (value) {
                          setState(() {
                            keepMeLoggedIn = value!;
                          });
                        }),
                  ),
                  Text(
                    'Remmber Me',
                    style: GoogleFonts.lobster(color: Colors.white),
                  )
                ],
              ),
            ),
            SizedBox(
              height: height * .03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      'Don\'t have an account ? ',
                      style: GoogleFonts.lobster(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, SignUpScreen.id);
                      },
                      child: Text(
                        'SignUp'.toUpperCase(),
                        style: GoogleFonts.lobster(
                          fontSize: 16,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: height * .03,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      Provider.of<AdminMode>(context, listen: false)
                          .changeIsAdmin(true);
                    },
                    child: Text(
                      'i\'m an admin',
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.lobster(
                          color: Provider.of<AdminMode>(context).isAdmin
                              ? kMainColor
                              : Colors.white),
                    ),
                  )),
                  GestureDetector(
                    onTap: () {
                      Provider.of<AdminMode>(context, listen: false)
                          .changeIsAdmin(false);
                    },
                    child: Expanded(
                        child: Text(
                      'i\'m an user',
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.lobster(
                          color: Provider.of<AdminMode>(context, listen: true)
                                  .isAdmin
                              ? Colors.white
                              : kMainColor),
                    )),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void Validate(BuildContext context) async {
    if (globalKey.currentState!.validate()) {
      globalKey.currentState!.save();
      if (Provider.of<AdminMode>(context, listen: false).isAdmin) {
        if (password == adminPassword) {
          try {
            await auth.signIn(email!, password!);

            Navigator.pushNamed(context, AdminHomeScreen.id);
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.black,
              content: Text(e.toString()),
            ));
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.black,
            content: Text('Somthing Went Wrong !'),
          ));
        }
      } else {
        try {
          await auth.signIn(email!, password!);
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomeScreen()));
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.black,
            content: Text(e.toString()),
          ));
        }
      }
    }
  }

  void keepUserLoggedIn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setBool(kKeepMeLoggedIn, keepMeLoggedIn);
  }
}
