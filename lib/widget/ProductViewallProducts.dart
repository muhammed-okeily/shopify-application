// ignore_for_file: prefer_const_constructors

import 'package:animate_do/animate_do.dart';
import 'package:buying/constants.dart';
import 'package:buying/functions.dart';
import 'package:buying/screens/user/productInfo.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../models/productModel.dart';
import '../screens/user/widget/homeimage.dart';

Widget ProductViewAllProduct(String pCategory, List<Product> allproducts) {
  List<Product> products;
  products = getProductByCategory(pCategory, allproducts);
  if (products.isNotEmpty) {
    return GridView.builder(
      reverse: true,
      scrollDirection: Axis.horizontal,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, childAspectRatio: 1.1),
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, ProductInfo.id,
                arguments: products[index]);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: kMainColor,
                    blurRadius: 6,
                    spreadRadius: 3,
                    offset: Offset(0, 2),
                  )
                ],
              ),
              child: Stack(
                children: [
                  FadeInDown(
                      child: HomeImage(
                          imagePath: products[index].pLocation.toString())),
                  Positioned(
                    bottom: 0,
                    child: Opacity(
                      opacity: 0.75,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        color: Colors.grey[350],
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                products[index].pName.toString(),
                                style: GoogleFonts.lobster(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '\$${products[index].pPrice.toString()}',
                                style: GoogleFonts.lobster(
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      itemCount: products.length,
    );
  } else {
    return Center(
      child: Lottie.network(
        "https://assets7.lottiefiles.com/packages/lf20_kyi8qg4t.json",
        fit: BoxFit.cover,
      ),
    );
  }
}
