// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print

import 'package:animate_do/animate_do.dart';
import 'package:buying/constants.dart';
import 'package:buying/models/UserModel.dart';
import 'package:buying/provider/modelhud.dart';
import 'package:buying/screens/user/HomeScreen.dart';
import 'package:buying/screens/LoginScreen.dart';
import 'package:buying/services/auth.dart';
import 'package:buying/widget/customLogo.dart';
import 'package:buying/widget/customTextField.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  static String id = 'SignUpScreen';
  String? email, password, name;
  final auth = Auth();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kMainColor,
      body: ProgressHUD(
        child: Form(
          key: globalKey,
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 50),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment
                        .center, // ignore: prefer_const_literals_to_create_immutables
                    children: <Widget>[
                      Lottie.network(
                          "https://assets4.lottiefiles.com/packages/lf20_yravkfyg.json",
                          width: 70,
                          fit: BoxFit.cover,
                          height: 70),
                      Positioned(
                        bottom: 0,
                        child: Text(
                          "Signup",
                          style: GoogleFonts.lobster(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                            letterSpacing: 5,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Positioned(
                        child: FadeInRight(
                          child: Text(
                            "Please sign up to continue",
                            style: GoogleFonts.lobster(
                              color: Colors.white60,
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              letterSpacing: 3,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height * .1,
              ),
              CustomTextField(
                  onClick: (value) {
                    name = value;
                  },
                  hint: 'Enter your name ..',
                  icon: Icons.person_sharp),
              SizedBox(
                height: height * .02,
              ),
              CustomTextField(
                  onClick: (value) {
                    email = value;
                  },
                  hint: 'Enter your email ..',
                  icon: Icons.email_rounded),
              SizedBox(
                height: height * .02,
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
                child: Builder(builder: (context) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    onPressed: () async {
                      final modelhud =
                          Provider.of<ModelHud>(context, listen: false);
                      modelhud.changeisLoading(true);
                      if (globalKey.currentState!.validate()) {
                        globalKey.currentState?.save();
                        try {
                          final authResult = await auth.signUp(
                              email!.trim(), password!.trim());

                          auth.addUser(Users(
                              uName: name, uEmail: email, uPassword: password));
                          modelhud.changeisLoading(false);
                          Navigator.pushNamed(context, HomeScreen.id);
                        } catch (e) {
                          modelhud.changeisLoading(false);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.black,
                            content: Text(e.toString()),
                          ));
                        }
                      }
                      modelhud.changeisLoading(false);
                    },
                    child: Text('Sign Up',
                        style: GoogleFonts.lato(color: Colors.white)),
                  );
                }),
              ),
              SizedBox(
                height: height * .04,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        'Do have an account ? ',
                        style: GoogleFonts.lobster(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, LoginScreen.id);
                        },
                        child: Text(
                          'Login',
                          style: GoogleFonts.lobster(
                            fontSize: 14,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
