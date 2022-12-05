import 'package:buying/constants.dart';
import 'package:buying/provider/cartItem.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProductBuy extends StatelessWidget {
  final String price;
  final void Function()? onTap;
  const ProductBuy({super.key, required this.price, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 1,
          width: double.infinity,
          color: Colors.black,
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              price,
              style: GoogleFonts.lobster(
                  color: kMainColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  letterSpacing: 2),
            ),
            addCartButton()
          ],
        )
      ],
    );
  }

  Widget addCartButton() {
    return Container(
      padding: const EdgeInsets.only(top: 5, bottom: 5, right: 8, left: 8),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(25),
        boxShadow: const [
          BoxShadow(
            color: kMainColor,
            blurRadius: 8,
            spreadRadius: 3,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            const Icon(
              (Icons.shopping_cart_outlined),
              color: Colors.white,
              size: 30,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              "Add To Cart".toUpperCase(),
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
