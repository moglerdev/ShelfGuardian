import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shelf_guardian/auth/bloc/auth_state.dart';
import 'package:shelf_guardian/auth/views/sign_in_page.dart';
import 'package:shelf_guardian/editor/views/editor_page.dart';
import 'package:shelf_guardian/filter/filter_page.dart';
import 'package:shelf_guardian/scanner/views/scanner_page.dart';
import 'package:shelf_guardian/settings/views/setting_page.dart';
import 'package:shelf_guardian/product/views/product_page.dart';

final routes = GoRouter(
    routes: [
      GoRoute(
        path: "/auth/sign-in",
        builder: (context, state) => const SignInPage(),
      ),
      GoRoute(
        path: "/auth/sign-up",
        builder: (context, state) => const SignInPage(),
      ),
      GoRoute(
        path: "/auth/forgot-password",
        builder: (context, state) => const SignInPage(),
      ),
      GoRoute(
        path: "/",
        builder: (context, state) => const ProductPage(),
      ),
      GoRoute(
        path: "/scanner",
        builder: (context, state) => const ScannerPage(),
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
      final isAuthRoute = state.fullPath!.startsWith("/auth");
      final isAuthenticated = AuthenticationState.of(context).isAuthenticated;

      if (isAuthenticated && isAuthRoute) {
        return "/";
      } else if (!isAuthenticated && !isAuthRoute) {
        return "/auth/sign-in";
      }

      return null;
    });
