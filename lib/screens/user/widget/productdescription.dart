// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDesc extends StatelessWidget {
  final String description;
  const ProductDesc({
    super.key,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Description ",
            style: GoogleFonts.lobster(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
                letterSpacing: 2),
          ),
          SizedBox(height: 10),
          Text(
            description,
            style: GoogleFonts.lobster(
                fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 2),
          )
        ],
      ),
    );
  }
}
