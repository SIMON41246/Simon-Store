import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_app/presentation/main/utils/cart_list.dart';
import 'package:ecommerce_app/presentation/resources/string_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class StoreDetails extends StatefulWidget {
  const StoreDetails({Key? key}) : super(key: key);

  @override
  State<StoreDetails> createState() => _StoreDetailsState();
}

class _StoreDetailsState extends State<StoreDetails> {
  var product = Get.arguments;
  int value = 0;

  void incrementvalue() {
    setState(() {
      value++;
    });
  }

  void decrementvalue() {
    setState(() {
      if (value > 0) {
        value--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  height: 400,
                  child: Center(
                      child: Image.network(
                    product.image,
                    fit: BoxFit.contain,
                  ))),
              Padding(
                padding: EdgeInsets.all(19),
                child: Text(
                  product.title,
                  style: GoogleFonts.dmSerifDisplay(
                    fontSize: 30,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.deepOrangeAccent.shade200,
                          borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        children: [
                          Text(
                            "${product.price.toString()} £",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Text(
                            " ${product.rating.count.toString()} In Stock",
                            style: GoogleFonts.dmSerifDisplay(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          product.rating.rate.toString(),
                          style: GoogleFonts.abhayaLibre(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow.shade900,
                          size: 30,
                        )
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    child: ElevatedButton(
                      onPressed: () {
                        addtoCart();
                        if (kDebugMode) {
                          print(product);
                        }
                      },
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.only(
                                  right: 100, left: 100, bottom: 20, top: 20))),
                      child: Text(AppStrings.paynow.tr()),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.blueGrey, shape: BoxShape.circle),
                      child: IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          incrementvalue();
                        },
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text("${value}",
                        style: GoogleFonts.dmSerifDisplay(
                            fontSize: 15, color: Colors.black)),
                    SizedBox(
                      width: 15,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.blueGrey, shape: BoxShape.circle),
                      child: IconButton(
                        icon: Icon(
                          Icons.remove,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          decrementvalue();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  AppStrings.description.tr(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 18, right: 18, top: 5, bottom: 15),
                child: Text(
                  product.description,
                  style: GoogleFonts.aBeeZee(fontSize: 15),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void addtoCart() {
    if (value > 0) {
      var shop = context.read<CartList>();
      shop.addToCart(product, value);

      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: const Color.fromARGB(255, 127, 53, 48),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.done,
                      color: Colors.white,
                    ))
              ],
              shape: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              content:  Text(
                AppStrings.orderSuccess.tr(),
                style: const TextStyle(color: Colors.white),
              ),
            );
          });
    } else {
      final snackBar = SnackBar(
        /// need to set following properties for best effect of awesome_snackbar_content
        elevation: 0,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: AppStrings.warning.tr(),
          message: AppStrings.orderYet.tr(),

          /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
          contentType: ContentType.help,
        ),
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }
}
