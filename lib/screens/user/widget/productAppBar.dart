// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../cartScreen.dart';

class ProductAppBar extends StatefulWidget {
  final String title;
  const ProductAppBar({super.key, required this.title});

  @override
  State<ProductAppBar> createState() => _ProductAppBarState();
}

class _ProductAppBarState extends State<ProductAppBar> {
  bool isFavourite = false;
  String? shopping;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black54,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        },
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      title: Text(
        widget.title,
        style: GoogleFonts.lobster(
            fontWeight: FontWeight.bold, letterSpacing: 5, color: Colors.black),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: IconButton(
            onPressed: () {
              setState(() {
                isFavourite = !isFavourite;
              });
            },
            icon: isFavourite
                ? const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  )
                : const Icon(
                    Icons.favorite_border_outlined,
                    color: Colors.black,
                  ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: IconButton(
            icon: shopping != null
                ? Icon(
                    Icons.shopping_cart,
                    color: Colors.black,
                  )
                : Icon(
                    Icons.shopping_cart,
                    color: Colors.black,
                  ),
            onPressed: () {
              Navigator.pushNamed(context, CartScreen.id);
            },
          ),
        )
      ],
    );
  }
}
