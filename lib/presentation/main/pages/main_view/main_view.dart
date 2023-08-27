import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_app/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';

import '../../../resources/string_manager.dart';
import '../../../resources/values_manager.dart';
import '../home/home_page.dart';
import '../settings/settings.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<Widget> pages = [const HomeScreen(), const SettingsPage()];
  List<String> titles = [
    AppStrings.home.tr(),
    AppStrings.search.tr(),
    AppStrings.notification.tr(),
    AppStrings.settings.tr(),
  ];
  var currentIndex = 0;
  var _title = AppStrings.home.tr();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: pages[currentIndex]),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(color: color_manager.primary, spreadRadius: AppSize.s1_5)
        ]),
        child: BottomNavigationBar(
          selectedItemColor: color_manager.primary,
          unselectedItemColor: color_manager.grey,
          currentIndex: currentIndex,
          onTap: onTap,
          items: [
            BottomNavigationBarItem(
                icon: const Icon(Icons.home), label: AppStrings.home.tr()),
            BottomNavigationBarItem(
                icon: const Icon(Icons.settings),
                label: AppStrings.settings.tr()),
          ],
        ),
      ),
    );
  }

  onTap(int index) {
    setState(() {
      currentIndex = index;
      _title = titles[index];
    });
  }
}
