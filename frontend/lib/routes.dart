import 'package:go_router/go_router.dart';
import 'package:shelf_guardian/pages/home_page.dart';
import 'package:shelf_guardian/pages/scanner_page.dart';
import 'package:shelf_guardian/pages/setting_page.dart';

final routes = GoRouter(routes: [
  GoRoute(
    path: "/",
    builder: (context, state) => const HomePage(),
  ),
  GoRoute(
    path: "/scanner",
    builder: (context, state) => const ScannerPage(),
  ),
  GoRoute(
    path: "/scanner/:id",
    builder: (context, state) => const ScannerPage(),
  ),
  GoRoute(
    path: "/settings",
    builder: (context, state) => const SettingPage(),
  ),
  GoRoute(
    path: "/search",
    builder: (context, state) => const HomePage(),
  ),
]);
