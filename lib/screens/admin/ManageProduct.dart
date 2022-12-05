// ignore_for_file: prefer_const_constructors

import 'package:buying/constants.dart';
import 'package:buying/models/productModel.dart';
import 'package:buying/screens/admin/EditProduct.dart';
import 'package:buying/services/store.dart';
import 'package:buying/widget/customPopMenu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class ManageProducts extends StatefulWidget {
  const ManageProducts({super.key});
  static String id = 'ManageProducts ';

  @override
  State<ManageProducts> createState() => _EditProductsState();
}

class _EditProductsState extends State<ManageProducts> {
  final store = Store();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream: store.loadProducts(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Product> products = [];
                for (var doc in snapshot.data!.docs) {
                  Map<String, dynamic> data =
                      doc.data() as Map<String, dynamic>;
                  products.add(Product(
                      pId: doc.id,
                      pPrice: data[kProductPrice],
                      pName: data[kProductName],
                      pDescription: data[kProductDescription],
                      pLocation: data[kProductLocation],
                      pCategory: data[kProductCategory]));
                }
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 0.8),
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: GestureDetector(
                      onTapUp: (details) {
                        double dx = details.globalPosition.dx;
                        double dy = details.globalPosition.dy;
                        double dx2 = MediaQuery.of(context).size.width - dx;
                        double dy2 = MediaQuery.of(context).size.width - dy;
                        showMenu(
                            context: context,
                            position: RelativeRect.fromLTRB(dx, dy, dx2, dy2),
                            items: [
                              MyPopupMenuItem(
                                  child: Text(
                                    'Edit',
                                    style: GoogleFonts.lobster(),
                                  ),
                                  onClick: () {
                                    Navigator.pushNamed(context, EditProduct.id,
                                        arguments: products[index]);
                                  }),
                              MyPopupMenuItem(
                                  child: Text(
                                    'Delete',
                                    style: GoogleFonts.lobster(),
                                  ),
                                  onClick: () {
                                    store.deleteProduct(products[index].pId);
                                    Navigator.pop(context);
                                  }),
                            ]);
                      },
                      child: Stack(
                        children: [
                          Positioned.fill(
                              child: Image(
                                  fit: BoxFit.fill,
                                  image: AssetImage(
                                      products[index].pLocation.toString()))),
                          Positioned(
                            bottom: 0,
                            child: Opacity(
                              opacity: 0.6,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 60,
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        products[index].pName.toString(),
                                        style: GoogleFonts.lobster(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        '\$ ${products[index].pPrice.toString()}',
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
            }));
  }
}
