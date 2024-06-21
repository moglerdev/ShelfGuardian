import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shelf_guardian/auth/bloc/auth_state.dart';
import 'package:shelf_guardian/auth/views/forgot_password_page.dart';
import 'package:shelf_guardian/auth/views/sign_in_page.dart';
import 'package:shelf_guardian/auth/views/sign_up_page.dart';
import 'package:shelf_guardian/editor/views/editor_page.dart';
import 'package:shelf_guardian/filter/filter_page.dart';
import 'package:shelf_guardian/scanner/views/scanner_page.dart';
import 'package:shelf_guardian/settings/views/settings_page.dart';
import 'package:shelf_guardian/product/views/product_page.dart';
import 'package:shelf_guardian/common/routes_service.dart';

final routes = GoRouter(
    routes: [
      GoRoute(
        path: NavigationServiceRoutes.signInRouteUri,
        builder: (context, state) => const SignInPage(),
      ),
      GoRoute(
        path: NavigationServiceRoutes.signUpRouteUri,
        builder: (context, state) => const SignUpPage(),
      ),
      GoRoute(
        path: NavigationServiceRoutes.forgotPasswordRouteUri,
        builder: (context, state) => const ForgotPasswordPage(),
      ),
      GoRoute(
        path: NavigationServiceRoutes.homeRouteUri,
        builder: (context, state) => const ProductPage(),
      ),
      GoRoute(
        path: NavigationServiceRoutes.scannerRouteUri,
        builder: (context, state) => const ScannerPage(),
      ),
      GoRoute(
          path: NavigationServiceRoutes.editorWithIdRouteUri(':id'),
          builder: (context, state) {
            final id = state.pathParameters['id'] ?? '';
            return EditorPage(code: id);
          }),
      GoRoute(
          path: NavigationServiceRoutes.editorRouteUri,
          builder: (context, state) {
            return const EditorPage(code: "");
          }),
      GoRoute(
        path: NavigationServiceRoutes.settingsRouteUri,
        builder: (context, state) => const SettingsPage(),
      ),
      GoRoute(
        path: NavigationServiceRoutes.filterRouteUri,
        builder: (context, state) => const FilterPage(),
      ),
    ],
    redirect: (BuildContext context, GoRouterState state) {
      debugPrint(state.fullPath);
      final isAuthRoute = state.fullPath!.startsWith("/auth");
      final isAuthenticated = AuthenticationState.of(context).isAuthenticated;

      if (isAuthenticated && isAuthRoute) {
        return NavigationServiceRoutes.homeRouteUri;
      } else if (!isAuthenticated && !isAuthRoute) {
        return NavigationServiceRoutes.signInRouteUri;
      }

      return null;
    });
