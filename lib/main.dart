import 'package:buying/constants.dart';
import 'package:buying/provider/admin.dart';
import 'package:buying/provider/cartItem.dart';
import 'package:buying/provider/modelhud.dart';
import 'package:buying/screens/admin/orderdetails.dart';
import 'package:buying/screens/user/HomeScreen.dart';
import 'package:buying/screens/LoginScreen.dart';
import 'package:buying/screens/admin/EditProduct.dart';
import 'package:buying/screens/admin/adminHomeScreen.dart';
import 'package:buying/screens/signupSceen.dart';
import 'package:buying/screens/user/productInfo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/admin/addProduct.dart';
import 'screens/admin/ManageProduct.dart';
import 'screens/admin/ordersScreen.dart';
import 'screens/user/cartScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  bool isUserLoggedIn = false;
  bool UserDataInCart = false;
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Container(
                child: Lottie.network(
                  "https://assets7.lottiefiles.com/packages/lf20_kyi8qg4t.json",
                  fit: BoxFit.cover,
                ),
              ),
            );
          } else {
            isUserLoggedIn = snapshot.data?.getBool(kKeepMeLoggedIn) ?? false;
     

            return MultiProvider(
              providers: [
                ChangeNotifierProvider<ModelHud>(
                  create: (context) => ModelHud(),
                ),
                ChangeNotifierProvider<CartItem>(
                  create: (context) => CartItem(),
                ),
                ChangeNotifierProvider<AdminMode>(
                  create: (context) => AdminMode(),
                ),
              ],
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                initialRoute: isUserLoggedIn ? HomeScreen.id : LoginScreen.id,
                routes: {
                  LoginScreen.id: (context) => LoginScreen(),
                  SignUpScreen.id: (context) => SignUpScreen(),
                  HomeScreen.id: (context) => HomeScreen(),
                  AdminHomeScreen.id: (context) => AdminHomeScreen(),
                  AddProduct.id: (context) => AddProduct(),
                  ManageProducts.id: (context) => ManageProducts(),
                  OrdersScreen.id: (context) => OrdersScreen(),
                  EditProduct.id: (context) => EditProduct(),
                  ProductInfo.id: (context) => ProductInfo(),
                  CartScreen.id: (context) => CartScreen(),
                  OrderDetails.id: (context) => OrderDetails(),
                },
              ),
            );
          }
        });
  }
}
