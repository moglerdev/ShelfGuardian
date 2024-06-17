import 'package:go_router/go_router.dart';
import 'package:shelf_guardian/editor/views/editor_page.dart';
import 'package:shelf_guardian/filter/filter_page.dart';
import 'package:shelf_guardian/scanner/views/scanner_page.dart';
import 'package:shelf_guardian/settings/setting_page.dart';
import 'package:shelf_guardian/product/views/product_page.dart';
import 'package:shelf_guardian/views/test.dart';

final routes = GoRouter(routes: [
  GoRoute(
    path: "/",
    builder: (context, state) => const HomePage(),
  ),
  GoRoute(
    path: "/scanner",
    builder: (context, state) => ScannerPage(),
  ),
  GoRoute(
      path: "/editor/:id",
      builder: (context, state) {
        final id = state.pathParameters['id'] ?? '';
        return EditorPage(code: id);
      }),
  GoRoute(
      path: "/editor",
      builder: (context, state) {
        return const EditorPage(code: "");
      }),
  GoRoute(
    path: "/settings",
    builder: (context, state) => const SettingPage(),
  ),
  GoRoute(
    path: "/filter",
    builder: (context, state) => const FilterPage(),
  ),
]);
