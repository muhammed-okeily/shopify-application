import 'package:buying/constants.dart';
import 'package:flutter/material.dart';

class HomeImage extends StatelessWidget {
  final String imagePath;
  const HomeImage({Key? key, required this.imagePath}) : super(key: key);

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
            color: Colors.white,
            blurRadius: 12,
            spreadRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
    );
  }
}
