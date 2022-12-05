import 'package:animate_do/animate_do.dart';
import 'package:buying/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final IconData? icon;
  final Function(String?)? onClick;
  String? errorMsg(String str) {
    switch (hint) {
      case 'Enter your name ..':
        return 'Name is empty !';
      case 'Enter your email ..':
        return 'Email is empty !';
      case 'Enter your password ..':
        return 'Password is empty !';
    }
  }

  const CustomTextField(
      {super.key, required this.hint, this.icon, this.onClick});

  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: TextFormField(
          validator: ((value) {
            if (value!.isEmpty) {
              return errorMsg(hint);
            }
          }),
          onSaved: onClick,
          obscureText: hint == 'Enter your password ..' ? true : false,
          cursorColor: kMainColor,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(
              icon,
              color: kMainColor,
            ),
            
            filled: true,
            fillColor: kSecondaryColor,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.white)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.white)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.white)),
            hintStyle: GoogleFonts.lobster(
              color: const Color.fromARGB(255, 155, 153, 153),
            ),
          ),
        ),
      ),
    );
  }
}
