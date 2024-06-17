import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shelf_guardian/auth/bloc/auth_state.dart';
import 'package:shelf_guardian/auth/views/sign_in_page.dart';
import 'package:shelf_guardian/editor/views/editor_page.dart';
import 'package:shelf_guardian/filter/filter_page.dart';
import 'package:shelf_guardian/scanner/views/scanner_page.dart';
import 'package:shelf_guardian/settings/setting_page.dart';
import 'package:shelf_guardian/product/views/product_page.dart';

final routes = GoRouter(
    routes: [
      GoRoute(
        path: "/sign-in",
        builder: (context, state) => const SignInPage(),
      ),
      GoRoute(
        path: "/",
        builder: (context, state) => const ProductPage(),
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
    ],
    redirect: (BuildContext context, GoRouterState state) {
      debugPrint(state.fullPath);
      if (!AuthenticationState.of(context).isAuthenticated) {
        return "/sign-in";
      }
      if (state.fullPath == "/sign-in") {
        return "/";
      }
      return null;
    });
