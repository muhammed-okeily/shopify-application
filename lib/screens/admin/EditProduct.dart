// ignore_for_file: unused_local_variable

import 'package:buying/constants.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/productModel.dart';
import '../../services/store.dart';
import '../../widget/customTextField.dart';

class EditProduct extends StatefulWidget {
  static String id = 'EditProduct';

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  String? name, price, description, category, imageLocation;

  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  final store = Store();
  final List<String> CategoryItems = [
    kJackets,
    kTrousers,
    kTshirts,
    kShoes,
  ];
  String? selectedCategoryValue;
  final List<String> ImageItems = [
    'assets/images/trousers/trouser1.jpg',
    'assets/images/trousers/trouser2.jpg',
    'assets/images/trousers/trouser3.jpg',
    'assets/images/trousers/trouser4.jpg',
    'assets/images/trousers/trouser5.jpg',
    'assets/images/trousers/trouser6.jpg',
    'assets/images/trousers/trouser7.jpg',
    //
    'assets/images/t-shirts/t-shirt1.jpg',
    'assets/images/t-shirts/t-shirt2.jpg',
    'assets/images/t-shirts/t-shirt3.jpg',
    'assets/images/t-shirts/t-shirt4.jpg',
    'assets/images/t-shirts/t-shirt5.jpg',
    'assets/images/t-shirts/t-shirt6.jpg',
    //
    'assets/images/shoes/shoe1.jpg',
    'assets/images/shoes/shoe2.jpg',
    'assets/images/shoes/shoe3.jpg',
    'assets/images/shoes/shoe4.jpg',
    'assets/images/shoes/shoe5.jpg',
    'assets/images/shoes/shoe6.jpg',
    //
    'assets/images/jackets/jacket1.jpg',
    'assets/images/jackets/jacket2.jpg',
    'assets/images/jackets/jacket3.jpg',
    'assets/images/jackets/jacket4.jpg',
    'assets/images/jackets/jacket5.jpg',
    'assets/images/jackets/jacket6.jpg',
    'assets/images/jackets/jacket7.jpg',
    'assets/images/jackets/jacket8.jpg',
    'assets/images/jackets/jacket9.jpg',
    'assets/images/jackets/jacket10.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    Product? product = ModalRoute.of(context)!.settings.arguments as Product?;
    return Scaffold(
      body: Form(
          key: globalKey,
          child: ListView(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .2,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextField(
                    hint: 'Product Name',
                    onClick: (value) {
                      name = value;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    hint: 'Product Price',
                    onClick: (value) {
                      price = value;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    hint: 'Product Description',
                    onClick: (value) {
                      description = value;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        isExpanded: true,
                        hint: Row(
                          children: [
                            Icon(
                              Icons.list,
                              size: 16,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Expanded(
                              child: Text(
                                'Select Category',
                                style: GoogleFonts.lobster(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        items: CategoryItems.map(
                            (item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: GoogleFonts.lobster(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )).toList(),
                        value: category,
                        onChanged: (value) {
                          setState(() {
                            category = value as String;
                          });
                        },
                        icon: const Icon(
                          Icons.arrow_forward_ios_outlined,
                        ),
                        iconSize: 14,
                        iconEnabledColor: Colors.black,
                        iconDisabledColor: Colors.black,
                        buttonHeight: 50,
                        buttonWidth: 300,
                        buttonPadding:
                            const EdgeInsets.only(left: 14, right: 14),
                        buttonDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: Colors.white,
                          ),
                          color: kMainColor,
                        ),
                        buttonElevation: 2,
                        itemHeight: 40,
                        itemPadding: const EdgeInsets.only(left: 10, right: 10),
                        dropdownMaxHeight: 200,
                        dropdownWidth: 200,
                        dropdownPadding: null,
                        dropdownDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: kMainColor,
                        ),
                        dropdownElevation: 8,
                        scrollbarRadius: const Radius.circular(20),
                        scrollbarThickness: 6,
                        scrollbarAlwaysShow: true,
                        offset: const Offset(-20, 0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        isExpanded: true,
                        hint: Row(
                          children: [
                            Icon(
                              Icons.list,
                              size: 16,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Expanded(
                              child: Text(
                                'Select Image location',
                                style: GoogleFonts.lobster(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        items:
                            ImageItems.map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: GoogleFonts.lobster(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                )).toList(),
                        value: imageLocation,
                        onChanged: (value) {
                          setState(() {
                            imageLocation = value as String;
                          });
                        },
                        icon: const Icon(
                          Icons.arrow_forward_ios_outlined,
                        ),
                        iconSize: 14,
                        iconEnabledColor: Colors.black,
                        iconDisabledColor: Colors.black,
                        buttonHeight: 50,
                        buttonWidth: 300,
                        buttonPadding:
                            const EdgeInsets.only(left: 14, right: 14),
                        buttonDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: Colors.white,
                          ),
                          color: kMainColor,
                        ),
                        buttonElevation: 2,
                        itemHeight: 40,
                        itemPadding: const EdgeInsets.only(left: 10, right: 10),
                        dropdownMaxHeight: 200,
                        dropdownWidth: 300,
                        dropdownPadding: EdgeInsets.all(10),
                        dropdownDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: kMainColor,
                        ),
                        dropdownElevation: 8,
                        scrollbarRadius: const Radius.circular(20),
                        scrollbarThickness: 0,
                        scrollbarAlwaysShow: true,
                        offset: const Offset(0, 0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    onPressed: () {
                      if (globalKey.currentState!.validate()) {
                        globalKey.currentState!.save();
                        // globalKey.currentState!.reset();
                        store.editProduct({
                          kProductName: name,
                          kProductLocation: imageLocation,
                          kProductCategory: category,
                          kProductDescription: description,
                          kProductPrice: price
                        }, product?.pId);
                      }
                    },
                    child: Text(
                      'Edit Product'.toUpperCase(),
                      style: GoogleFonts.lato(fontSize: 21),
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
