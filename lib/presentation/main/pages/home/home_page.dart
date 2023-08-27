import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/presentation/main/pages/home/controller.dart';
import 'package:ecommerce_app/presentation/resources/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart' hide Trans;
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../resources/routes_manager.dart';
import '../../../resources/string_manager.dart';
import '../../../store_details/store_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DataController dataController = Get.put(DataController());

  void navigatetoStoreDetails(int index) {
    Get.to(const StoreDetails(), arguments: dataController.productlist[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text(AppStrings.appName.tr(),
            style: GoogleFonts.adventPro(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(Routes.cartRoute);
            },
            icon: Icon(Icons.shopping_cart),
          ),
        ],
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
      ),
      body: Obx(() => dataController.isDataLoading.value
          ? Center(
              child: Container(
                  width: 150,
                  height: 150,
                  child: Lottie.asset(JsonAssets.loading)))
          : _builScreen(dataController.productlist)),
    );
  }

  Widget _builScreen(RxList<Products> productlist) {
    return getGridViewProducts(productlist);
  }

  Widget getGridViewProducts(RxList<Products> productlist) {
    return MasonryGridView.builder(
        gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2),
        itemCount: productlist.length,
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
                onTap: () {
                  navigatetoStoreDetails(index);
                },
                child: Card(
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      FadeInImage.assetNetwork(
                        placeholder: "assets/gif/loading.gif",
                        image: productlist[index].image,
                        placeholderFit: BoxFit.contain,
                        fit: BoxFit.contain,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                "${productlist[index].price.toString()}£",
                                style: Theme.of(context).textTheme.titleMedium),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  productlist[index].rating.rate.toString(),
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 30,
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                )),
          );
        });
  }
}
