import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_app/app/binding.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import '../presentation/resources/routes_manager.dart';
import '../presentation/resources/theme_manager.dart';
import 'app_preferences.dart';
import 'di.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppPrefrences _appPrefrences = instance<AppPrefrences>();

  @override
  void didChangeDependencies() {
    _appPrefrences.getLocal().then((local) => context.setLocale(local));

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: context.locale,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      theme: getApplicationTheme(),
      debugShowCheckedModeBanner: false,
      getPages: RouteConstant.getPages,
      initialBinding: AppBindings(),
      title: 'Simon Shop',
      initialRoute: Routes.splashRoute,
    );
    ;
  }
}
