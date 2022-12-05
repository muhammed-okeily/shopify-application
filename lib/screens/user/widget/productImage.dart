import 'package:buying/constants.dart';
import 'package:flutter/material.dart';

class ProductView extends StatelessWidget {
  final String imagePath;
  const ProductView({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.3,
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage(
            imagePath,
          ),
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: kMainColor,
            blurRadius: 12,
            spreadRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
    );
  }
}
