import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_app/presentation/resources/string_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/cart_list.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CartList>(
        builder: (context, value, child) => Scaffold(
              appBar: AppBar(
                iconTheme: IconThemeData(color: Colors.white),
                backgroundColor: Color.fromARGB(255, 127, 53, 48),
                title: Center(
                    child: Text(
                  "My Cart",
                  style: TextStyle(color: Colors.white),
                )),
              ),
              body: Container(
                color: Color.fromARGB(255, 127, 53, 48),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: value.list.length,
                          itemBuilder: (context, index) {
                            final dynamic food = value.list[index];
                            final String foodname = food.title;
                            final String foodprice = food.price.toString();
                            return Container(
                              margin: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color.fromARGB(255, 155, 107, 104),
                              ),
                              child: ListTile(
                                leading: Image.network(food.image),
                                title: Text(
                                  foodname,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                subtitle: Text(
                                  foodprice,
                                  style: TextStyle(color: Colors.grey.shade900),
                                ),
                                trailing: IconButton(
                                  onPressed: () {
                                    value.removeFromCart(food);
                                  },
                                  icon: Icon(Icons.delete),
                                ),
                              ),
                            );
                          }),
                    ),
                    ElevatedButton(
                      style: const ButtonStyle(
                          padding: MaterialStatePropertyAll(
                              EdgeInsets.symmetric(
                                  horizontal: 60, vertical: 10))),
                      child: Text(AppStrings.paynow.tr()),
                      onPressed: () {
                        if (value.list.isEmpty) {
                          final snackBar = SnackBar(
                            /// need to set following properties for best effect of awesome_snackbar_content
                            elevation: 0,
                            duration: const Duration(seconds: 2),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.transparent,
                            content: AwesomeSnackbarContent(
                              title: AppStrings.warning.tr(),
                              message: AppStrings.orderYet.tr(),

                              /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                              contentType: ContentType.warning,
                            ),
                          );
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(snackBar);
                        } else {
                          showModalBottomSheet<void>(
                            backgroundColor: Color.fromARGB(255, 230, 217, 217),
                            shape: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30))),
                            // context and builder are
                            // required properties in this widget
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                margin: EdgeInsets.only(top: 70),
                                child: Expanded(
                                  child: ListView(
                                    children: [
                                      ListTile(
                                        title: Text("PayPal"),
                                        leading: Image.asset(
                                            "assets/images/paypal.png"),
                                        trailing: TextButton(
                                          onPressed: () {},
                                          child: Text("Pay Now"),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      ListTile(
                                        title: Text("\t Card"),
                                        leading: Image.asset(
                                            "assets/images/payment.png"),
                                        trailing: TextButton(
                                          onPressed: () {},
                                          child: Text("Pay Now"),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      ListTile(
                                        title: Text("\t Payonner"),
                                        leading: Image.asset(
                                            "assets/images/Payoneer-square.png"),
                                        trailing: TextButton(
                                          onPressed: () {},
                                          child: Text("Pay Now"),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ));
  }
}
