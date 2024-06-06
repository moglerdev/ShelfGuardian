import 'package:flutter/material.dart';
import 'package:shelf_guardian/pages/home_page.dart';
import 'package:shelf_guardian/pages/scanner_page.dart';
import 'package:shelf_guardian/pages/setting_page.dart';

class AppRoutes {
  static void back(BuildContext context) {
    Navigator.pop(context);
  }

  static void navigateToHome(BuildContext context) {
    MaterialPageRoute<HomePage> route = MaterialPageRoute(
        builder: (context) => const HomePage(), fullscreenDialog: true);
    Navigator.push(context, route);
  }

  static void navigateToScanner(BuildContext context) {
    MaterialPageRoute<ScannerPage> route = MaterialPageRoute(
        builder: (context) => const ScannerPage(), fullscreenDialog: true);
    Navigator.push(context, route);
  }

  static void navigateToSetting(BuildContext context) {
    MaterialPageRoute<SettingPage> route = MaterialPageRoute(
        builder: (context) => const SettingPage(), fullscreenDialog: true);
    Navigator.push(context, route);
  }
}
