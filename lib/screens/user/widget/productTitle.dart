import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductTitle extends StatelessWidget {
  final String title;
  const ProductTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 30),
        child: Row(
          children: [
            Text(
              title,
              style: GoogleFonts.lobster(
                  color: Colors.black,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2),
            ),
          ],
        ),
      ),
    );
  }
}
