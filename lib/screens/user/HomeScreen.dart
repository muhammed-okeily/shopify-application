// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:animate_do/animate_do.dart';
import 'package:buying/constants.dart';
import 'package:buying/functions.dart';

import 'package:buying/screens/LoginScreen.dart';
import 'package:buying/screens/user/productInfo.dart';
import 'package:buying/screens/user/widget/homeimage.dart';

import 'package:buying/services/auth.dart';
import 'package:buying/widget/ProductViewallProducts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/productModel.dart';
import '../../services/store.dart';
import 'cartScreen.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final auth = Auth();
  int tabBarIndex = 0;
  int bottomBarIndex = 0;
  final store = Store();
  List<Product> _products = [];
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DefaultTabController(
          length: 4,
          child: Scaffold(
            bottomNavigationBar: CurvedNavigationBar(
                animationCurve: Curves.easeInOutCubicEmphasized,
                height: 50,
                backgroundColor: Colors.white,
                index: bottomBarIndex,
                color: kMainColor,
                onTap: (value) async {
                  if (value == 1) {
                    SharedPreferences pref =
                        await SharedPreferences.getInstance();
                    pref.clear();
                    await auth.signOut();
                    Navigator.popAndPushNamed(context, LoginScreen.id);
                  }

                  setState(() {
                    bottomBarIndex = value;
                  });
                },
                items: [
                  Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  Icon(
                    Icons.exit_to_app_outlined,
                    color: Colors.white,
                  )
                ]),
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              bottom: TabBar(
                isScrollable: true,
                indicatorColor: Colors.white,
                onTap: (value) {
                  setState(() {
                    tabBarIndex = value;
                  });
                },
                tabs: [
                  Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(13),
                      ),
                      color: kMainColor,
                    ),
                    child: Text(
                      'Jackets',
                      style: GoogleFonts.lobster(
                        color: tabBarIndex == 0 ? Colors.black : Colors.white,
                        fontSize: tabBarIndex == 0 ? 16 : 16,
                        fontWeight: tabBarIndex == 0 ? FontWeight.bold : null,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(13),
                      ),
                      color: kMainColor,
                    ),
                    child: Text(
                      'Trousers',
                      style: GoogleFonts.lobster(
                        color: tabBarIndex == 1 ? Colors.black : Colors.white,
                        fontSize: tabBarIndex == 1 ? 16 : 16,
                        fontWeight: tabBarIndex == 1 ? FontWeight.bold : null,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(13),
                      ),
                      color: kMainColor,
                    ),
                    child: Row(
                      children: [
                        Text(
                          'T-Shirts',
                          style: GoogleFonts.lobster(
                            color:
                                tabBarIndex == 2 ? Colors.black : Colors.white,
                            fontSize: tabBarIndex == 2 ? 16 : 16,
                            fontWeight:
                                tabBarIndex == 2 ? FontWeight.bold : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      color: kMainColor,
                    ),
                    child: Text(
                      'Shoes',
                      style: GoogleFonts.lobster(
                        color: tabBarIndex == 3 ? Colors.black : Colors.white,
                        fontSize: tabBarIndex == 3 ? 16 : 16,
                        fontWeight: tabBarIndex == 3 ? FontWeight.bold : null,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                JacketView(),
                ProductViewAllProduct(kTrousers, _products),
                ProductViewAllProduct(kTshirts, _products),
                ProductViewAllProduct(kShoes, _products),
              ],
            ),
          ),
        ),
        Material(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Discover'.toUpperCase(),
                    style: GoogleFonts.lobster(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, CartScreen.id);
                      },
                      child: Icon(Icons.shopping_cart))
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    getCurrenUser();
  }

  getCurrenUser() async {
    auth.getUser().toString();
  }

  Widget JacketView() {
    return StreamBuilder<QuerySnapshot>(
        stream: store.loadProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Product>? products = [];
            for (var doc in snapshot.data!.docs) {
              Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

              products.add(Product(
                  pId: doc.id,
                  pPrice: data[kProductPrice],
                  pName: data[kProductName],
                  pDescription: data[kProductDescription],
                  pLocation: data[kProductLocation],
                  pCategory: data[kProductCategory]));
            }
            _products = [...products];
            products.clear();
            products = getProductByCategory(kJackets, _products);
            return GridView.builder(
              scrollDirection: Axis.horizontal,
             
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, childAspectRatio: 1.1),
              itemBuilder: (context, index) => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, ProductInfo.id,
                        arguments: products![index]);
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
                                  imagePath:
                                      products![index].pLocation.toString())),
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
                ),
              ),
              itemCount: products.length,
            );
          } else {
            return Center(
              child: Lottie.network(
                  "https://assets7.lottiefiles.com/packages/lf20_kyi8qg4t.json",
                  width: 70,
                  fit: BoxFit.cover,
                  height: 70),
            );
          }
        });
  }
}
