import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_app/presentation/main/utils/cart_list.dart';
import 'package:ecommerce_app/presentation/resources/language_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';

import 'app/app.dart';
import 'app/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initAppModule();
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartList(),
      child: EasyLocalization(
        supportedLocales: const [ARABIC_LOCALE, ENGLISH_LOCALE],
        path: ASSET_PATH_LOCALISATION,
        child: Phoenix(child: const MyApp()),
      ),
    ),
  );
}
