// ignore_for_file: use_key_in_widget_constructors, sized_box_for_whitespace, prefer_const_constructors

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class CustomLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
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
                "Login",
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
                  "Please sign in to continue",
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
    );
  }
}
