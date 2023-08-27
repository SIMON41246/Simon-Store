import 'dart:math' as math;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../app/app_preferences.dart';
import '../../../../app/di.dart';
import '../../../../data/remote_data_source/local_data_source.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/language_manager.dart';
import '../../../resources/routes_manager.dart';
import '../../../resources/string_manager.dart';
import '../../../resources/values_manager.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final AppPrefrences _appPrefrences = instance();
  final LocalDataSource _localDataSource = instance();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        padding: const EdgeInsets.all(AppPaddingManager.p8),
        children: [
          ListTile(
            title: Text(
              AppStrings.changeLanguage.tr(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            leading: SvgPicture.asset(ImageAssets.changeLanguage),
            trailing: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(isRtl() ? math.pi : 0),
              child: SvgPicture.asset(ImageAssets.arrowSettings),
            ),
            onTap: () {
              _changeLanguage();
            },
          ),
          ListTile(
            title: Text(
              AppStrings.contactUs.tr(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            leading: SvgPicture.asset(ImageAssets.contactus),
            trailing: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(isRtl() ? math.pi : 0),
              child: SvgPicture.asset(ImageAssets.arrowSettings),
            ),
            onTap: () async {
              launchEmailSubmission();
            },
          ),
          ListTile(
            title: Text(
              AppStrings.inviteYourFriends.tr(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            leading: SvgPicture.asset(ImageAssets.inviteFriends),
            trailing: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(isRtl() ? math.pi : 0),
              child: SvgPicture.asset(ImageAssets.arrowSettings),
            ),
            onTap: () {
              Share.share(AppStrings.shareapp.tr());
            },
          ),
          ListTile(
            title: Text(
              AppStrings.logout.tr(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            leading: SvgPicture.asset(ImageAssets.logout),
            trailing: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(isRtl() ? math.pi : 0),
              child: SvgPicture.asset(ImageAssets.arrowSettings),
            ),
            onTap: () {
              _logout();
            },
          ),
        ],
      ),
    );
  }

  _logout() {
    _appPrefrences.logout();
    _localDataSource.clearCache();
    Get.offNamed(Routes.LoginRoute);
  }

  _changeLanguage() {
    _appPrefrences.changeAppLanguage();
    Phoenix.rebirth(context);
  }

  bool isRtl() {
    return context.locale == ARABIC_LOCALE;
  }

  void launchEmailSubmission() async {
    final Uri params = Uri(
        scheme: 'mailto',
        path: 'mohammedezrouil@gmail.com',
        query: 'subject=Default Subject&body=Default body');

    String url = params.toString();
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      print('Could not launch $url');
    }
  }
}
